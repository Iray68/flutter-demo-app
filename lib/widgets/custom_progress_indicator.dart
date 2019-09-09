import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80.0,
        width: 80.0,
        child: const CircularProgressIndicator(),
      ),
    );
  }

}