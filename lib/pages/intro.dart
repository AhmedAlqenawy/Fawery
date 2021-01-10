import 'package:concentric_transition/page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nice_intro/intro_screen.dart';

import 'home.dart';
import 'login.dart';

class Intro extends StatefulWidget {
  static const routeName = '/IntroOverboardPage';
  @override
  _IntroOverboardPageState createState() => _IntroOverboardPageState();
}

class _IntroOverboardPageState extends State<Intro>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
        key: _globalKey,
        body: SafeArea(
          child: ConcentricPageView(
              colors: colors,
              itemCount: pages.length,
              opacityFactor: 1.0,
              scaleFactor: 0.0,
              radius: 400,
              curve: Curves.ease,
              duration: Duration(seconds: 1),
              verticalPosition: 0.7,
              direction: Axis.vertical,
              itemBuilder: (index, value) {
                return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: ()async{
                                print('asd');
                                preferences = await SharedPreferences.getInstance();
                                preferences.setString("intro", "true");
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FHome()));
                              },
                              child: Text(
                                  index ==pages.length-1? "Done":'Skip',
                                  style: GoogleFonts.arapey(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: index%2==1?Colors.black87:Colors.white,
                                  )
                              ),
                            ),
                            SizedBox(width: 30,),
                            SizedBox()
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(300)
                          ),
                          child: Image.asset(
                            pages[index].imageAsset,
                            width: 300,height: 230,
                          ),
                        ),
                        Container(padding: EdgeInsets.only(top: 30),
                            child: Text(pages[index].title,
                                style: GoogleFonts.elMessiri(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: index%2==1?Colors.black87:Colors.white,
                                )
                            )
                        ),
                        SizedBox(height: 40,),
                        Container(
                            padding: EdgeInsets.only(top: 55),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  pages[index].description,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: index%2==0?Colors.black87:Colors.white,
                                  )
                              ),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(),
                            GestureDetector(
                                onTap: ()async{
                                  preferences = await SharedPreferences.getInstance();
                                  preferences.setString("intro", "true");
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FHome()));
                                },
                                child: Icon(Icons.arrow_forward,color: index%2==0?Colors.black87:Colors.white)),
                          ],
                        )
                      ],
                    ));
              }
          ),
        )
    );
  }

  List<IntroScreen> pages = [
    IntroScreen(
      title: 'Online Shopping',
      textStyle: TextStyle(color:  Colors.white),
      imageAsset: 'assets/onlineshopping.png',
      description:
      'Shopping anywhere,anytime and get a great shopping experience',
      headerBgColor: Colors.white,
    ),
    IntroScreen(
      textStyle: TextStyle(color:  Colors.white),
      title: 'Supermarket In Your House',
      headerBgColor: Colors.white,
      imageAsset: 'assets/Super.png',
      description:
      "All consumer products of meat ,fresh and Frozen (meat_poultry_fish),   canned products , Fruits,Vegetables and Legumes",
    ),
    IntroScreen(
      textStyle: TextStyle(color:  Colors.white),
      title: 'Favoirte Kitchen and restaurant',
      headerBgColor: Colors.white,
      imageAsset: 'assets/eat2.png',
      description:"Keep talking with ur family and friends and order food from any restaurant around u ,with Our delivary service it tooks minuites ",

    ),
  ];

  List<Color> colors = [Color(0xFF009999),Color(0xFFebebe0)];
}