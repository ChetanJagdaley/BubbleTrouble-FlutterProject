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

enum direction { left, right }

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
  var ballDirection = direction.left;

  void resetMissile() {
    missileX = playerX;
    missileHeight = 10;
    midshot = false;
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

        //reset missile when it hits the top
        if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
          resetMissile();
          timer.cancel();
        }

        //checks if missile hits the ball
        if(ballY>heightToCoordinate(missileHeight) && (ballX-missileX).abs()<0.03){
          resetMissile();
          ballY=5;
          timer.cancel();
        }
      });
    }
  }

  void startGame() {

    double time = 0 ;
    double height = 0 ;
    double velocity = 100; // how strong the jump is 
    Timer.periodic(Duration(milliseconds: 20), (Timer) {

      //quadratic equation that models a bounce (upside and parabola)
      height = -5 * time * time + velocity * time;


      // if the ball reaches the ground , reset the jump
      if(height<0){
        time = 0;
      }

      setState(() {
        ballY= heightToCoordinate(height);
      });

      time +=0.1;

      //if the ball hits the left wall change its direction to the right
      if (ballX - 0.03 < -1) {
        ballDirection = direction.right;
      }

      // if the ball hits the right wall change its direction to the right wall
       else if (ballX + 0.03 > 1) {
        ballDirection = direction.left;
      }

      if (ballDirection == direction.left) {
        setState(() {
          ballX -= .005;
        });

      } else if (ballDirection == direction.right) {
        setState(() {
          ballX += .005;
        });
      }
      if(playerDies()){
        Timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.grey,
        title: Text('You dead bruh!',
        style: TextStyle(
          color: Colors.white,
        ),),
      );
    });
  }

  bool playerDies(){
    //if the ball touches the player
    if((ballX-playerX).abs()<0.05 && ballY> 0.95){
      return true;
    }
    else{
      return false;
    }
  }


// this function convert height to coordinate
  double heightToCoordinate(double height){
    double totalHeight = MediaQuery.of(context).size.height*3/4;
    double missileY = 1-2*height/totalHeight;
    return missileY;
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
