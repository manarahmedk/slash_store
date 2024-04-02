part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetAllProductsLoadingState extends ProductState {}
class GetAllProductsSuccessState extends ProductState {}
class GetAllProductsErrorState extends ProductState {}

class GetProductDetailsLoadingState extends ProductState {}
class GetProductDetailsSuccessState extends ProductState {}
class GetProductDetailsErrorState extends ProductState {}

class ChangeFilterLoadingState extends ProductState {}
class ChangeFilterSuccessState extends ProductState {}
class ChangeFilterErrorState extends ProductState {}

class ChangeIndex extends ProductState {}