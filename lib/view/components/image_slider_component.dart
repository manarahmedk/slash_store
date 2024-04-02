import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_task/view_model/utils/colors.dart';

import '../../view_model/bloc/product_cubit/product_cubit.dart';

class ImageSliderComponent extends StatelessWidget {
  final String item;

  const ImageSliderComponent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          margin: const EdgeInsets.all(5.0),
          child: Image.network(
            item,
            fit: BoxFit.contain,
            width: 1500.0,
            height: 1500,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            },
          ),
        );
      },
    );
  }
}
