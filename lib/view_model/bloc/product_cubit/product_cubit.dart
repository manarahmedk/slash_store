import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_task/model/product_variation.dart';
import '../../../model/product.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/end_points.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  int current = 0;
  bool isSelected = true;

  void changeIndex(int index) {
    current = index;
    emit(ChangeIndex());
  }

  CarouselController controller = CarouselController();

  List<Product> products = [];

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoadingState());
    await DioHelper.get(endPoint: EndPoints.products).then((value) {
      products.clear();
      for (var i in value?.data['data']) {
        products.add(Product.fromJson(i));
      }
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetAllProductsErrorState());
    });
  }

  num? price;

  Product? currentProduct;

  List<ProductVariation> _variations = [];
  List<ProductVariation> variations = [];

  List<String> colors = [];
  List<String> sizes = [];
  List<String> materials = [];

  List<String> colorsImages = [];
  List<int> colorsId = [];

  List<String> get images {
    if (variations.isNotEmpty) {
      return variations
          .map((variation) =>
              variation.productVariantImages.map((e) => e.imagePath!))
          .expand((element) => element)
          .toSet()
          .toList()
          .sublist(0, imagesLength);
    } else {
      return variations
          .map((variation) =>
              variation.productVariantImages.map((e) => e.imagePath!))
          .expand((element) => element)
          .toSet()
          .toList();
    }
  }

  int imagesLength = 0;

  String? currentColor;
  String? currentSize;
  String? currentMaterial;

  Future<void> getProductDetails({required int? id}) async {
    emit(GetProductDetailsLoadingState());
    try {
      final response =
          await DioHelper.get(endPoint: "${EndPoints.products}/$id");
      final data = response?.data['data'];
      if (data != null) {
        currentProduct = Product.fromJson(data);

        // print(currentProduct?.id);

        currentColor=null;
        currentSize=null;
        currentMaterial=null;

        _variations = currentProduct!.variations!;
        variations = currentProduct!.variations!;

        imagesLength = _variations.first.productVariantImages.length;

        try {
          colors = currentProduct?.avaiableProperties
                  ?.firstWhere((property) => property.property == "Color")
                  .values
                  .map((e) => e.value)
                  .toSet()
                  .toList() ??
              [];
        } catch (error) {
          colors = [];
        }

        try {
          sizes = currentProduct?.avaiableProperties
              ?.firstWhere((property) => property.property == "Size")
              .values
              .map((e) => e.value)
              .toSet()
              .toList() ??
              [];
        } catch (error) {
          sizes = [];
        }

        try {
          materials = currentProduct?.avaiableProperties
                  ?.firstWhere((property) => property.property == "Materials")
                  .values
                  .map((e) => e.value)
                  .toSet()
                  .toList() ??
              [];
        } catch (error) {
          materials = [];
        }

        colorsId.clear();
        colorsImages.clear();

        if (colors.isNotEmpty) {
          currentColor = colors[0];

          int i = 0;
          for (i; i < colors.length; i++) {
            colorsId.add(currentProduct?.avaiableProperties
                    ?.firstWhere((property) => property.property == "Color")
                    .values
                    .firstWhere((value) => value.value == colors[i])
                    .id ??
                0);
          }

          i = 0;
          currentProduct?.variations?.forEach((variation) {
            if ((i < colorsId.length) && (variation.id == colorsId[i])) {
              colorsImages
                  .add(variation.productVariantImages[0].imagePath ?? "");
              i++;
            }
          });

        }

        if (materials.isNotEmpty) {
          currentMaterial = materials[0];
        }

        changeFilter(
            color: currentColor,
            size: currentSize,
            material: currentMaterial)
            .then((value) => value);

        if (sizes.isNotEmpty) {
          try {
            sizes=[];

            int i = 0;
            for (i; i < variations.length; i++) {
              sizes.add(variations[i].productPropertiesValues
                  ?.firstWhere((property) => property.property == "Size")
                  .value??"");
              sizes.toSet().toList();
            }
            currentSize=sizes[0];
          } catch (error) {
            sizes = [];
          }
        }
        changeFilter(
            color: currentColor,
            size: currentSize,
            material: currentMaterial)
            .then((value) => value);

        price=variations[0].price;


        // Notify state that product details are loaded successfully
        emit(GetProductDetailsSuccessState());
      } else {
        // Notify state of error when data is null
        emit(GetProductDetailsErrorState());
      }
    } catch (error) {
      // Log error and notify state of error
      log(error.toString());
      emit(GetProductDetailsErrorState());
    }
  }

  Future<void> changeFilter(
      {String? color, String? size, String? material}) async {
    emit(ChangeFilterLoadingState());

    current = 0;
    controller.animateToPage(current);

    try {

      variations = _variations.where((variation) {
        bool colorMatch = color == null || variation.productPropertiesValues!.any((property) => property.property == "Color" && property.value == color);
        bool sizeMatch = size == null || variation.productPropertiesValues!.any((property) => property.property == "Size" && property.value == size);
        bool materialMatch = material == null || variation.productPropertiesValues!.any((property) => property.property == "Materials" && property.value == material);

        return colorMatch && sizeMatch && materialMatch;
      }).toList();

      price=variations[0].price;

      emit(ChangeFilterSuccessState());
    } catch (error) {
      // Log error and notify state of error
      log(error.toString());
      emit(ChangeFilterErrorState());
    }
  }
}
