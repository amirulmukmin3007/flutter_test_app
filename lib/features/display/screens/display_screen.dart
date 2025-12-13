import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/features/display/bloc/display_bloc.dart';
import 'package:flutter_test_app/features/display/models/product_model.dart';
import 'package:flutter_test_app/shared/widgets/custom_card.dart';
import 'package:flutter_test_app/shared/widgets/custom_chip.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  double? _selectedMinRating;

  List<ProductModel> _products = [];

  final List<double> _ratingFilters = [1.0, 2.0, 3.0, 4.0, 5.0];

  List<String> get _categories {
    if (_products.isEmpty) return [];

    final categories = _products
        .map((product) => product.category)
        .toSet()
        .toList();

    categories.sort();
    return categories;
  }

  List<ProductModel> get _filteredProducts {
    List<ProductModel> filtered = _products;

    if (_selectedCategory != null) {
      filtered = filtered.where((product) {
        return product.category == _selectedCategory;
      }).toList();
    }

    if (_selectedMinRating != null) {
      filtered = filtered.where((product) {
        return product.rating['rate'].toInt() == _selectedMinRating!;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  void _showProductDetails(ProductModel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<DisplayBloc>().add(DisplayLoadData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<DisplayBloc, DisplayState>(
        builder: (context, state) {
          if (state is DisplayLoading) {
            return Scaffold(
              backgroundColor: colors.primary,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is DisplayDataLoaded) {
            _products = state.products;

            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: AppBar(
                title: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(FluentIcons.search_16_filled),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              FluentIcons.text_clear_formatting_16_filled,
                            ),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              body: Column(
                children: [
                  if (_categories.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                            child: Row(
                              children: [
                                Icon(
                                  FluentIcons.filter_16_filled,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: const Text('All'),
                                    selected: _selectedCategory == null,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = null;
                                      });
                                    },
                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    backgroundColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      color: _selectedCategory == null
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                ..._categories.map((category) {
                                  final isSelected =
                                      _selectedCategory == category;
                                  return CustomChip(
                                    label: category,
                                    isSelected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = selected
                                            ? category
                                            : null;
                                      });
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: 8),
                                Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: const Text('All'),
                                    selected: _selectedMinRating == null,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedMinRating = null;
                                      });
                                    },
                                    selectedColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    backgroundColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      color: _selectedMinRating == null
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                ..._ratingFilters.reversed.map((rating) {
                                  final isSelected =
                                      _selectedMinRating == rating;

                                  return CustomChip(
                                    ratingFlag: true,
                                    label: rating.toInt().toString(),
                                    isSelected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedMinRating = selected
                                            ? rating
                                            : null;
                                      });
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                  Expanded(
                    child: _filteredProducts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.error_circle_16_filled,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return CustomCard(
                                product: product,
                                onTap: () => _showProductDetails(product),
                              );
                            },
                          ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                // onPressed: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => CartPage()),
                // ),
                backgroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }

          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
