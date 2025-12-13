part of 'display_bloc.dart';

abstract class DisplayState {}

class DisplayInitial extends DisplayState {}

class DisplayLoading extends DisplayState {}

class DisplayDataLoaded extends DisplayState {
  final List<ProductModel> products;
  DisplayDataLoaded({required this.products});
}
