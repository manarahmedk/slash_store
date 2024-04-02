import 'package:flutter/material.dart';
import 'package:slash_task/view_model/utils/colors.dart';

import '../../model/product.dart';
import 'custom_text.dart';

class ProductComponent extends StatelessWidget {
  final Product product;
  final void Function()? onTap;

  const ProductComponent(
      {super.key, required this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  color: AppColors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(
                    product.variations?[0].productVariantImages[0].imagePath ??
                        "",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomText(
                            text:
                                "${product.name} - ${product.brand?.brandName}",
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            height: 30,
                            width: 30,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 13,
                              child: ClipOval(
                                child: Image.network(
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  product.brand?.brandLogoImagePath ?? "",
                                  errorBuilder:  (context, error, stackTrace) {
                                    return Image.asset('assets/images/Slash.jpg');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex:5,
                          child: CustomText(
                            text: 'EGP ${product.variations?[0].price} ',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Expanded(
                          flex:2,
                          child: Icon(Icons.favorite_outline,color: AppColors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
