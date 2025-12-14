part of 'cart_bloc.dart';

abstract class CartEvent {}

class CartLoadData extends CartEvent {}

class CartAddItem extends CartEvent {
  final ProductModel product;
  CartAddItem({required this.product});
}

class CartRemoveItem extends CartEvent {
  final ProductModel product;
  CartRemoveItem({required this.product});
}

class CartClearData extends CartEvent {}
