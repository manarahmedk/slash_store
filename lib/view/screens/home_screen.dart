import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_task/view/components/custom_text.dart';
import 'package:slash_task/view/components/product_component.dart';
import 'package:slash_task/view/screens/product_details_screen.dart';
import 'package:slash_task/view_model/utils/colors.dart';

import '../../view_model/bloc/product_cubit/product_cubit.dart';
import '../../view_model/utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return BlocProvider.value(
      value: ProductCubit.get(context)..getAllProducts(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Slash.',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        return ProductComponent(
                          product: cubit.products[index],
                          onTap: () {
                            cubit.current = 0;
                            cubit
                                .getProductDetails(id: cubit.products[index].id)
                                .then((value) {
                              Navigation.push(
                                  context, const ProductDetailsScreen());
                            });
                          },
                        );
                      },
                      itemCount: cubit.products.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
