import 'package:flutter/material.dart';

class UnimeetBrand extends StatelessWidget {
  UnimeetBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Uni',
          style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFC107)),
        ),
        Text(
          'Meet',
          style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFF07F7FF)),
        ),
      ],
    );
  }
}
