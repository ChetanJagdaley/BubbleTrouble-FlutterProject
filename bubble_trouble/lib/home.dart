import 'package:flutter/material.dart';
import 'button.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.pink[200],
          )),
         Expanded(
          child: Container(
            color: Colors.grey[500],
            child: Row(
              children: [
                MyButton(),
              ],),
          )),
      ],
    );
  }
}