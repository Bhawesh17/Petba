import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/screens/user/login_screen.dart';

class Onboard extends StatefulWidget {
  static const String id = 'IntroScreen';
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  double windowHeight;

  double windowWidth;
  int offset = 0;
  var x = new List(5); //x is the x axis offset
  var a = new List(5); //a is the active state of the buttons
  String buttonName = 'Allow';

  void initialize() {
    for (int i = 0; i < 5; i++) {
      x[i] = windowWidth * i;
    }
    a[0] = true;
    for (int j = 1; j < 5; j++) {
      a[j] = false;
    }
  }

  void sliderChange() {
    offset = offset + 1;
    if (offset >= 5) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      setState(() {
        for (int i = 0; i < 5; i++) {
          x[i] = x[i] - windowWidth;
        }
        a[offset] = true;
        a[offset - 1] = false;
        buttonName = 'Next';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    if (offset == 0) {
      initialize();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            height: windowHeight - 80,
            child: Column(
              children: [
                Expanded(child: Text(''), flex: 1),
                Stack(
                  children: [
                    Slider(
                      x: x[0],
                      img: 'images/Img4.png',
                      question: '',
                      title: 'Can I Ring You?',
                      description:
                          "To serve you the best user experience we need permission to send you notifications",
                    ),
                    Slider(
                      x: x[1],
                      img: 'images/Img5.png',
                      question: 'What can you do ?',
                      title: 'Shop our Favourites',
                      description:
                          "Buy pet products with online payment or cash on delivery",
                    ),
                    Slider(
                      x: x[2],
                      img: 'images/Img6.png',
                      question: 'What can you do?',
                      title: 'Shelter us',
                      description:
                          "Choose any Public or Private shelters for the pets",
                    ),
                    Slider(
                      x: x[3],
                      img: 'images/Img7.png',
                      question: 'What can you do?',
                      title: 'Rescue us',
                      description:
                          "Share the location for rescuing any animals",
                    ),
                    Slider(
                      x: x[4],
                      img: 'images/Img8.png',
                      question: 'What can you do ?',
                      title: 'Adopt us',
                      description:
                          "Adopt Pets from a wide range of options and give them the best care",
                    ),
                  ],
                ),
                SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Dots(active: a[0]),
                      Dots(active: a[1]),
                      Dots(active: a[2]),
                      Dots(active: a[3]),
                      Dots(active: a[4]),
                    ],
                  ),
                ),
                Expanded(child: Text(''), flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        padding: EdgeInsets.all(0),
                        child: Text(
                          '<   Skip',
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: FlatButton(
                        onPressed: () {
                          sliderChange();
                        },
                        padding: EdgeInsets.all(0),
                        child: Text(
                          buttonName + '   >',
                          style: TextStyle(
                            color: Color(0xffFF5180),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dots extends StatelessWidget {
  Dots({this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) {
    double width = 12;
    Color colour = Color(0xffE1E7F6);
    if (active) {
      colour = Color(0xffFEA593);
      width = 25;
    }
    return Container(
      height: 7,
      width: width,
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  Slider({
    @required this.x,
    @required this.img,
    this.question = '',
    this.title,
    this.description,
  });
  final double x;
  final String img;
  final String question;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      //height: 480,
      transform: Matrix4.translationValues(x, 0, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 270,
              width: 300,
              child: Image.asset(img),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffFEA593),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff253150),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 250,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xffABABAB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
