import 'package:flutter/material.dart';

Widget customThrobber() {
  return Container(
    height: 120,
    width: 120,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Color(0xFFFF6D1F)),
        const SizedBox(height: 12),
        Text("Please wait..."),
      ],
    ),
  );
}
