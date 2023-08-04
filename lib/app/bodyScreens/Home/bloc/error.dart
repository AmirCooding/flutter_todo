import 'package:flutter/material.dart';

class MyError extends StatelessWidget {
  final String error;

  const MyError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.red),
      child: Center(
        child: Text(
          error,
          style: const TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
