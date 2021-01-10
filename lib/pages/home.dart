import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:skeleton_text/skeleton_text.dart';

import 'login.dart';

class FHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<FHome> {
  List categories = [];
  fetchAllCategories() async {
    try {
      var url = 'https://www.fawrydelivery.com/api/GetCategory';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData['status'] == 1) {
        setState(() {
          categories = extractedData['data'];
        });
      } else {
        setState(() {
          categories = [];
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.white10;
  final Color active = Colors.black;

  @override
  void initState() {
    fetchAllCategories();
    super.initState();
  }

  AutoSizeText autoText(String text,int maxLine,double fontSize , [Color color=Colors.black]){
    return AutoSizeText(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.visible,
        textDirection: TextDirection.rtl,
        textAlign:TextAlign.center,
        style:color!=Colors.black?
        GoogleFonts.elMessiri(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: color,

        ):
        TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: color,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Stack(
          children: <Widget>[
            // Stroked text as border.
            Text(
              'FawryDelivery',
              style: TextStyle(
                fontSize: 22,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.white,
              ),
            ),
            // Solid text as fill.
            Text(
              'FawryDelivery',
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),




      drawer: _buildDrawer(),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Image.network(
                      "https://miro.medium.com/max/7724/1*zgDEFpjiPHvHgVILSBjnVQ.jpeg",
                      fit: BoxFit.fill,
                    )
                        : index == 1
                        ? Image.network(
                      "https://rotana.net/assets/uploads/2017/02/%D8%A7%D9%84%D8%AA%D8%AC%D8%A7%D8%B11.jpg",
                      fit: BoxFit.fill,
                    )
                        : Image.network(
                      "https://www.um.edu.mt/__data/assets/image/0003/431985/varieties/acadhomelink.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemWidth: MediaQuery.of(context).size.width * 0.9,
                  itemHeight: MediaQuery.of(context).size.height * 0.22,
                  layout: SwiperLayout.STACK,
                  autoplay: true,
                  loop: true,
                  pagination: SwiperPagination(),
                ),
              ),
            ),
            Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: AnimationLimiter(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(
                            categories.length == 0 ? 10 : categories.length,
                                (index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration:  Duration(milliseconds:  index*400),
                                columnCount: 2,
                                child: SlideAnimation(
                                  child: FlipAnimation(
                                    child: categories.length == 0
                                        ? SkeletonAnimation(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black45,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(1, 3))
                                          ],
                                        ),
                                      ),
                                    )
                                        : GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black45,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(1, 3))
                                            ],
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://www.fawrydelivery.com/public/upload/categories/${categories[index]['cat_img']}"),
                                                fit: BoxFit.fill)),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: autoText(
                                              categories[index]['name'],
                                              1,
                                              20,
                                              Colors.white),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(25),
                                              gradient: LinearGradient(
                                                  begin: Alignment(1, 1),
                                                  end: Alignment(1, 0.2),
                                                  colors: [
                                                    Colors.black54,
                                                    Colors.transparent,
                                                  ])),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _buildDrawer() {
    final String image = 'asset/images/logo.jpg';
    return ClipPath(
      clipper: OvalRightBorderClipper(),

      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.amber])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "erika costell",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18.0),
                  ),

                  Text(
                    "@erika07",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>SignInScreen(),
                      ));
                    },
                    child: _buildRow(
                        Icons.person_pin,
                        "Sign In",
                    ),
                  ),
                  _buildDivider(),
                  _buildRow(Icons.person_add, "Sign Up"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.language, "Language"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------------------
  /// Building divider for drawer .
  /// ---------------------------
  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }
  /// ---------------------------
  /// Building item  for drawer .
  /// ---------------------------
  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }



  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}