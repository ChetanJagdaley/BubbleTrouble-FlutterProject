import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: 50,
      height: 50,
      child: Text('x'),
    );
  }
}