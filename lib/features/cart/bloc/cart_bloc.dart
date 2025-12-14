import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/features/cart/repositories/cart_repository.dart';
import 'package:flutter_test_app/features/display/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc({required CartRepository repository})
    : _repository = repository,
      super(CartInitial()) {
    on<CartLoadData>(_loadData);
    on<CartAddItem>(_addItem);
    on<CartRemoveItem>(_removeItem);
    on<CartClearData>(_clearData);
  }

  Future<void> _loadData(CartLoadData event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final savedCart = await _repository.loadCart();
    emit(CartUpdated(cartItems: savedCart));
  }

  void _addItem(CartAddItem event, Emitter<CartState> emit) {
    final updatedCart = List<ProductModel>.from(state.cartItems);
    final existingIndex = updatedCart.indexWhere(
      (item) => item.id == event.product.id,
    );

    if (existingIndex == -1) {
      updatedCart.add(event.product);
      emit(CartUpdated(cartItems: updatedCart));

      _repository.saveCart(updatedCart);
    } else {
      print('Product already in cart');
    }
  }

  void _removeItem(CartRemoveItem event, Emitter<CartState> emit) {
    final updatedCart = List<ProductModel>.from(state.cartItems);
    updatedCart.removeWhere((item) => item.id == event.product.id);
    emit(CartUpdated(cartItems: updatedCart));

    _repository.saveCart(updatedCart);
  }

  void _clearData(CartClearData event, Emitter<CartState> emit) {
    emit(CartUpdated(cartItems: []));

    _repository.clearCart();
  }

  bool isInCart(int productId) {
    return state.cartItems.any((item) => item.id == productId);
  }
}
