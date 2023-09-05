import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:covidapp/view/World_States.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
 late final AnimationController _controller =AnimationController.unbounded(
     duration: Duration(seconds: 3),
     vsync: this);

  @override
  void initState() {
    // TODO: implement initState
  Timer(const Duration(seconds: 5),
      ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> WorldState()))
  );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
        AnimatedBuilder(animation: _controller,
            child: Container(
              height: 200,
              width: 200,
              child: const Center(
                child: Image(image:AssetImage('images/virus.png')),
              ),
            ),
            builder:(BuildContext context, Widget? child){
            return Transform.rotate(angle: _controller.value *2.0* math.pi,
                child: child,
            );
            }
        ),
            SizedBox(
              height:MediaQuery.of(context).size.height *.08,
            ),
            Align(
              alignment: Alignment.center,
                child
                : const Text ('Covid-19\n Tracker app',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
