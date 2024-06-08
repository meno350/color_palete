import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          //  Scaffold(
          //   body: Center(
          //     child: GestureDetector(
          //             onTap: (){
          //               setState(() {
          //                 height= 400;
          //                 width = 200;
          //                 colors = Colors.amber;
          //               });
          //             },
          //             child: AnimatedContainer(
          //               height: height,
          //               width: width,
          //               color: colors,
          //               duration: Duration(seconds: 1),
          //             ),
          //           ),
          //   )
          // ));
          HomePage(),
    );
  }
}

double height = 200;
double width = 100;
Color colors = Colors.purpleAccent;

// List<Color> myColors =[
//   Color(0xffA8E0ff),
//   Color(0xff89248c),
//   Color(0xff626668)
// ];
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final colors = const [
    ColorModel(color: Color(0xffA8E0ff), alignment: Alignment.topRight),
    ColorModel(color: Color(0xff89248c), alignment: Alignment.topCenter),
    ColorModel(color: Color(0xff626668), alignment: Alignment.bottomCenter),
    ColorModel(color: Color(0xfff40303), alignment: Alignment.bottomCenter),
    ColorModel(color: Color(0xff60f206), alignment: Alignment.topCenter),
    ColorModel(color: Color(0xff060000), alignment: Alignment.topLeft),
    ColorModel(color: Color(0xff0639f2), alignment: Alignment.bottomRight),
    ColorModel(color: Color(0xffb68686), alignment: Alignment.bottomLeft),
    ColorModel(color: Color(0xff7eab5f), alignment: Alignment.topCenter),
    ColorModel(color: Color(0xffbda1a1), alignment: Alignment.topLeft),
    ColorModel(color: Color(0xff556095), alignment: Alignment.bottomRight),
    ColorModel(color: Color(0xffbf6d6d), alignment: Alignment.bottomLeft)
  ];
  late ColorModel currentColor;
  late ColorModel preColor;
  late AnimationController animationController;
  @override
  void initState() {
    currentColor = colors.first;
    preColor = colors.last;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: // // GestureDetector(
            // //   onTap: (){
            // //     setState(() {
            // //       height= 400;
            // //       width = 500;
            // //       colors = Colors.amber;
            // //     });
            // //   },
            // //   child: AnimatedContainer(
            // //     height: height,
            // //     width: width,
            // //     color: colors,
            // //     duration: Duration(seconds: 1),
            // //   ),
            // // ),
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 16),
            //     height: 50,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Colors.purpleAccent
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text("Hello"),
            //         SizedBox(width:  10,),
            //         AnimatedCrossFade(
            //             firstChild: Text("first text "),
            //             firstCurve: Curves.bounceIn,
            //             secondChild: Text("hi group 60"),
            //             crossFadeState: CrossFadeState.showFirst,
            //
            //             duration: Duration(seconds: 5)
            //         )
            //       ],
            //     ),
            //   ),
            // )
            Column(
      children: [
        Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            color: preColor.color,
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return ClipPath(
                clipper: CustomPath(
                    animationController.value, currentColor.alignment),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  color: currentColor.color,
                ),
              );
            },
          ),
        ]),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentColor = colors[index];
                      animationController
                          .forward(from: 0)
                          .whenComplete(() => preColor = currentColor);
                    });
                  },
                  child: GridItem(
                    colorModel: colors[index],
                    //myColors[index],
                  ),
                );
              }),
        ),
      ],
    ));
  }
}

class GridItem extends StatelessWidget {
  ColorModel colorModel;
  // Color color;
  GridItem({super.key, required this.colorModel});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorModel.color,
    );
  }
}

class ColorModel {
  final Color? color;
  final Alignment alignment;

  const ColorModel({
    this.color,
    required this.alignment,
  });
}

class CustomPath extends CustomClipper<Path> {
  final double value;
  final Alignment alignment;
  CustomPath(this.value, this.alignment);
  @override
  Path getClip(Size size) {
    Path path = Path();
    if (alignment == Alignment.bottomCenter) {
      buildPath(
        path,
        size,
        Offset(size.width / 2, size.height / 2),
      );
    } else if (alignment == Alignment.topLeft) {
      buildPath(
        path,
        size,
        Offset(0, 0),
      );
    } else if (alignment == Alignment.topCenter) {
      buildPath(
        path,
        size,
        Offset(size.width / 2, 0),
      );
    } else if (alignment == Alignment.topRight) {
      buildPath(
        path,
        size,
        Offset(size.width, 0),
      );
    } else if (alignment == Alignment.bottomRight) {
      buildPath(
        path,
        size,
        Offset(0, size.height),
      );
    } else if (alignment == Alignment.bottomLeft) {
      buildPath(
        path,
        size,
        Offset(0, size.width / 2),
      );
    }

    // path.addOval(Rect.fromCenter(
    //
    //   center: Offset(0,0),
    //   width: size.width * value *3 ,
    //   height: size.height * value *3  ,
    // ));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  void buildPath(Path path, Size size, Offset offset) {
    path.addOval(Rect.fromCenter(
      center: offset,
      width: size.width * value,
      height: size.height * value,
    ));
  }
}
