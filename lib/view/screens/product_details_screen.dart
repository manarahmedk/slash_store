import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_task/view/components/custom_text.dart';
import 'package:slash_task/view_model/utils/colors.dart';
import '../../view_model/bloc/product_cubit/product_cubit.dart';
import '../components/image_slider_component.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const CustomText(
          text: ' Product Details ',
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  CarouselSlider(
                    items: cubit.images
                        .map(
                          (item) => ImageSliderComponent(item: item),
                        )
                        .toList(),
                    carouselController: cubit.controller,
                    options: CarouselOptions(
                      initialPage: cubit.current,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 1.3,
                      onPageChanged: (index, reason) {
                        cubit.changeIndex(index);
                      },
                      reverse: false,
                      enableInfiniteScroll: false,
                      animateToClosest: true,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 54,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: cubit.images.map((img) {
                        int index = cubit.images.indexOf(img);
                        return GestureDetector(
                          onTap: () => cubit.controller.animateToPage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: cubit.current == index
                                    ? Colors.yellow
                                    : AppColors.black, // Border color
                                width: cubit.current == index
                                    ? 2.0
                                    : 0.0, // Border width
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            margin: const EdgeInsets.all(5.0),
                            child: Image.network(
                              img,
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    //clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text: "${cubit.currentProduct?.name}",
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                fontSize: 18,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              CustomText(
                                text: 'EGP ${cubit.price} ',
                                fontSize: 15,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.black,
                                child: ClipOval(
                                  child: Image.network(
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                    cubit.currentProduct?.brandLogoUrl ?? "",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/Slash.jpg');
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text: '${cubit.currentProduct?.brandName} ',
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: cubit.colors.isNotEmpty,
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CustomText(
                                text: ' Select Color ',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: cubit.colors.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 54,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: cubit.colorsImages.map((img) {
                           int colorIndex = cubit.colorsImages.indexOf(img);
                            return GestureDetector(
                              onTap: () {
                                cubit.currentColor=cubit.colors[colorIndex];
                                cubit.changeFilter(color: cubit.currentColor).then((value) => value);
                                if (cubit.sizes.isNotEmpty) {
                                  try {
                                    cubit.sizes=[];

                                    int i = 0;
                                    for (i; i < cubit.variations.length; i++) {
                                      cubit.sizes.add(cubit.variations[i].productPropertiesValues
                                          ?.firstWhere((property) => property.property == "Size")
                                          .value??"");
                                      cubit.sizes.toSet().toList();
                                    }
                                    cubit.currentSize=cubit.sizes[0];
                                  } catch (error) {
                                    cubit.sizes = [];
                                  }
                                }
                                if (cubit.colors.isNotEmpty && cubit.sizes.isNotEmpty && cubit.materials.isNotEmpty) {
                                  cubit.changeFilter(color: cubit.currentColor, size: cubit.currentSize, material: cubit.currentMaterial).then((value) => value);
                                } else if (cubit.colors.isNotEmpty && cubit.sizes.isNotEmpty) {
                                  cubit.changeFilter(color: cubit.currentColor, size: cubit.currentSize,).then((value) => value);
                                } else if (cubit.colors.isNotEmpty && cubit.materials.isNotEmpty) {
                                  cubit.changeFilter(color: cubit.currentColor, material: cubit.currentMaterial).then((value) => value);
                                } else if (cubit.colors.isNotEmpty) {
                                  cubit.changeFilter(color: cubit.currentColor).then((value) => value);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: cubit.currentColor ==
                                            cubit.colors[colorIndex]
                                        ? Colors.yellow
                                        : AppColors.black, // Border color
                                    width: cubit.currentColor ==
                                            cubit.colors[colorIndex]
                                        ? 2.0
                                        : 0.0, // Border width
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                margin: const EdgeInsets.all(5.0),
                                child: Image.network(
                                  img,
                                  fit: BoxFit.cover,
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: cubit.sizes.isNotEmpty,
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CustomText(
                                text: ' Select Size ',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: cubit.sizes.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, sizeIndex) {
                            return GestureDetector(
                              onTap: () {
                                cubit.currentSize=cubit.sizes[sizeIndex];
                                if(cubit.colors.isNotEmpty&&cubit.sizes.isNotEmpty&&cubit.materials.isNotEmpty){
                                  cubit.changeFilter(color: cubit.currentColor,size: cubit.currentSize,material: cubit.currentMaterial).then((value) => value);
                                }else if(cubit.sizes.isNotEmpty&&cubit.materials.isNotEmpty){
                                  cubit.changeFilter(size: cubit.currentSize,material: cubit.currentMaterial).then((value) => value);
                                }else if(cubit.colors.isNotEmpty&&cubit.sizes.isNotEmpty){
                                  cubit.changeFilter(color: cubit.currentColor,size: cubit.currentSize).then((value) => value);
                                }else if(cubit.sizes.isNotEmpty){
                                  cubit.changeFilter(size: cubit.currentSize).then((value) => value);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: cubit.currentSize ==
                                          cubit.sizes[sizeIndex]
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                                child: CustomText(
                                  text: " ${cubit.sizes[sizeIndex]} ",
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, sizeIndex) =>
                              const SizedBox(
                            width: 15,
                          ),
                          itemCount: cubit.sizes.length,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: cubit.materials.isNotEmpty,
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CustomText(
                                text: ' Select Material ',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: cubit.materials.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, materialIndex) {
                            return GestureDetector(
                              onTap: () {
                                cubit.currentMaterial=cubit.materials[materialIndex];
                                if(cubit.colors.isNotEmpty&&cubit.sizes.isNotEmpty&&cubit.materials.isNotEmpty){
                                  cubit.changeFilter(color: cubit.currentColor,size: cubit.currentSize,material: cubit.currentMaterial).then((value) => value);
                                }else if ( cubit.sizes.isNotEmpty && cubit.materials.isNotEmpty) {
                                  cubit.changeFilter(size: cubit.currentColor, material: cubit.currentMaterial).then((value) => value);
                                }else if (cubit.colors.isNotEmpty && cubit.materials.isNotEmpty) {
                                  cubit.changeFilter(color: cubit.currentColor, material: cubit.currentMaterial).then((value) => value);
                                }else if ( cubit.materials.isNotEmpty) {
                                  cubit.changeFilter(material: cubit.currentMaterial).then((value) => value);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: cubit.currentMaterial ==
                                          cubit.materials[materialIndex]
                                      ? Colors.yellow
                                      : Colors.black12,
                                ),
                                child: CustomText(
                                  text: " ${cubit.materials[materialIndex]}",
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, materialIndex) =>
                              const SizedBox(
                            width: 15,
                          ),
                          itemCount: cubit.materials.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
