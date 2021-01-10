import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'intro.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>  with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  void initState() {
    super.initState();
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
      upperBound: 700,
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
      });
    });
    Timer(Duration(seconds: 3),()async{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      var intro=preferences.getString('intro');
      if(intro!="true")
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Intro()));
      else
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FHome()));
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top:0,
              left:-200+_animationController.value,
              child: Image(
                width: 200,
                height: 200,
                image: AssetImage('assets/delevary.png'),
              ),
            ),
            Positioned(
                top:150, //MediaQuery.of(context).size.height*0.4,
                left:100, //MediaQuery.of(context).size.width*0.3,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Image(
                    image: AssetImage("assets/fawrylogo.jpg"),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}