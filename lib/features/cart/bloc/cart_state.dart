part of 'cart_bloc.dart';

abstract class CartState {
  final List<ProductModel> cartItems;

  CartState({required this.cartItems});

  int get itemCount => cartItems.length;
  double get total => cartItems.fold(0, (sum, item) => sum + item.price);
}

class CartInitial extends CartState {
  CartInitial() : super(cartItems: []);
}

class CartLoading extends CartState {
  CartLoading() : super(cartItems: []);
}

class CartUpdated extends CartState {
  CartUpdated({required super.cartItems});
}
