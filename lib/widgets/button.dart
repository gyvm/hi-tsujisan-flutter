import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: const Text('Button'),
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          onPrimary: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
