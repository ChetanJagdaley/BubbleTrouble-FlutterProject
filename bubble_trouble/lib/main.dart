import 'package:flutter/material.dart';
import 'home.dart';

void main(){
  runApp(MyApp());
}
// yo hi why aint this reflecting on my git account is he mad or what
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}