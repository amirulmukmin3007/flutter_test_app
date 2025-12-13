import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/features/display/models/product_model.dart';
import 'package:flutter_test_app/features/display/repositories/display_repository.dart';

part 'display_event.dart';
part 'display_state.dart';

class DisplayBloc extends Bloc<DisplayEvent, DisplayState> {
  final DisplayRepository _displayRepository;

  DisplayBloc({required DisplayRepository displayRepository})
    : _displayRepository = displayRepository,
      super(DisplayInitial()) {
    on<DisplayLoadData>(_loadData);
  }

  Future<void> _loadData(
    DisplayLoadData event,
    Emitter<DisplayState> emit,
  ) async {
    emit(DisplayLoading());

    List<ProductModel> products = [];

    List<Map<String, dynamic>> data = await _displayRepository
        .fetchProductList();

    for (Map<String, dynamic> product in data) {
      products.add(ProductModel.fromJson(product));
    }

    emit(DisplayDataLoaded(products: products));
  }
}
