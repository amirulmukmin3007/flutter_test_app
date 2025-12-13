import 'dart:convert';

import 'package:flutter_test_app/shared/routes/api.dart';
import 'package:http/http.dart' as http;

class DisplayRepository {
  Future<List<Map<String, dynamic>>> fetchProductList() async {
    try {
      final response = await http.get(Uri.parse(Api.getProductList));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
}
