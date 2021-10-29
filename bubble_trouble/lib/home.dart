import 'dart:async';

import 'package:bubble_trouble/ball.dart';
import 'package:bubble_trouble/missile.dart';
import 'package:bubble_trouble/player.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

enum direction { LEFT, RIGHT }

class _HomepageState extends State<Homepage> {
  // player variables
  static double playerX = 0;

  //missile variables
  double missileX = playerX;
  double missileHeight = 10;
  bool midshot = false;

  //ball variables
  double ballX = 0.5;
  double ballY = 0;
  var ballDirection = direction.LEFT;

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
      if (!midshot) {
        missileX = playerX;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (playerX + .1 > 1) {
        //do nothing
      } else {
        playerX += .1;
      }
      if (!midshot) {
        missileX = playerX;
      }
    });
  }

  void fireMissile() {
    if (midshot == false) {
      Timer.periodic(Duration(milliseconds: 30), (timer) {
        //shot fired and we dont want another shot right away
        midshot = true;

        // missile will go up until it reaches the top
        setState(() {
          missileHeight += 10;
        });

        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
          midshot = false;
        }
      });
    }
  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: 50), (Timer) {
      if (ballX - 0.03 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.03 > 1) {
        ballDirection = direction.LEFT;
      }

      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= .03;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += .03;
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
                    MyBall(ballX: ballX, ballY: ballY),
                    MyMissile(
                      missileHeight: missileHeight,
                      missileX: missileX,
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
                icon: Icons.play_arrow,
                function: startGame,
              ),
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
