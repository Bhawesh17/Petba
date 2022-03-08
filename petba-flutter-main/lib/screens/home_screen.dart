import 'package:flutter/material.dart';
import 'package:petba/screens/adoption/adoption_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';

Color kThemeColour = Colors.black;
const String kAppName = 'Petba';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(kAppName),
        elevation: 3,
        toolbarHeight: 50.0,
        backgroundColor: kThemeColour,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'ABC',
            onPressed: () {
              //
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: kThemeColour,
              ),
              child: Center(
                child: Text(
                  kAppName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Adoption'),
              onTap: () {
                //
              },
            ),
            Divider(height: 8.0, color: Colors.grey.shade500),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Log Out'),
              onTap: () {
                //
              },
            ),
          ],
        ),
      ),
      body: HomePageData(),
    );
  }
}

class HomePageData extends StatefulWidget {
  @override
  _HomePageDataState createState() => _HomePageDataState();
}

class _HomePageDataState extends State<HomePageData> {
  double windowHeight;
  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(height: 20.0, color: kThemeColour),
                    Container(height: 30.0, color: Colors.white),
                  ],
                ),
                Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: 20.0,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 3.0),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "I'm looking for...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //
          SizedBox(
            height: windowHeight - 124,
            child: ListView(
              children: [
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdoptionPage.id);
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image(
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                                semanticLabel: 'Dog',
                                image: AssetImage('images/Dog1.jpg'),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Adoption',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: InkWell(
                        onTap: () {
                          //
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image(
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                                semanticLabel: 'Dog',
                                image: AssetImage('images/Dog2.jpg'),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Shelter',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: InkWell(
                        onTap: () {
                          //
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image(
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                                semanticLabel: 'Dog',
                                image: AssetImage('images/Dog3.jpg'),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '‽',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  height: 250.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Carousel(
                      boxFit: BoxFit.fill,
                      images: [
                        AssetImage('images/Dog6.jpg'),
                        AssetImage('images/Dog5.jpg'),
                        AssetImage('images/Dog4.jpg'),
                      ],
                      dotSize: 0.0,
                      indicatorBgPadding: 0.0,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                  ),
                ),

                //‽‽‽‽‽‽‽to display the owners review of getting the dog‽‽‽‽‽‽‽
                CategoryName(text: 'Happy Owners'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '"The dog is the god of frolic" - Henry',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '“Scratch a dog and you’ll find a permanent job.” – Franklin',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryName extends StatelessWidget {
  CategoryName({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
