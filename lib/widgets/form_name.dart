import 'package:flutter/material.dart';

class Nameform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 560,
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Title'),
        ),
      ),
    );
  }
}
