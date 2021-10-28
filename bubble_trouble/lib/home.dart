import 'dart:async';

import 'package:bubble_trouble/player.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // player variables
  static double playerX = 0;

  //missile variables
  double missileX = playerX;
  double missileY = 1;
  double missileHeight = 10;

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
  }

  void moveLeft() {
    setState(() {
     
      if (playerX - 0.1 < -1) {
        //do nothing
      } else {
        playerX -= .1;
      }
       missileX = playerX;
    });
  }

  void moveRight() {
    setState(() {
      
      if (playerX + .1 > 1) {
        //do nothing
      } else {
        playerX += .1;
      }
       missileX = playerX;
    });
   
  }

  void fireMissile() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
        resetMissile();
        timer.cancel();
      } else {
        setState(() {
          missileHeight += 10;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(missileX, missileY),
                      child: Container(
                        width: 5,
                        height: missileHeight,
                        color: Colors.grey,
                      ),
                    ),
                    MyPlayer(
                      playerX: playerX,
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
            child: Container(
          color: Colors.grey[500],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                icon: Icons.arrow_back,
                function: moveLeft,
              ),
              MyButton(
                icon: Icons.arrow_upward,
                function: fireMissile,
              ),
              MyButton(
                icon: Icons.arrow_forward,
                function: moveRight,
              ),
            ],
          ),
        )),
      ],
    );
  }
}
