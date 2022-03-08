import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petba/model/adoption.dart';
import 'package:petba/providers/adoption/adoptfirst.dart';
import 'package:petba/screens/padding.dart';
import 'package:petba/screens/user/user_details.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import 'package:petba/screens/adoption/adoption_search_screen.dart';
import 'package:petba/screens/veterinarian/vet_search_screen.dart';
import 'package:petba/screens/adoption/adoption_screen.dart';
import 'package:petba/screens/cart/cart_list.dart';
import 'package:petba/screens/ecommerce/ecommerce_search_screen.dart';
import 'package:petba/providers/DashboardProvider.dart';
import 'package:petba/screens/grooming/grooming_search_screen.dart';

import 'order/order_list_screen.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  static const id = 'home_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Logo.png',
                    width: 90,
                    // height: 92,
                  ),
                  Text(
                    'PETBA',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.home, color: kThemeColour),
              title: Text('Home', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.firstAid, color: kThemeColour),
              title: Text('Rescue', style: TextStyle(fontSize: 18)),
              onTap: () {
                //
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.paw, color: kThemeColour),
              title: Text('Adoption', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, adapt.id);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.store, color: kThemeColour),
              title: Text('Store', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, EcommerceSearch.id);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.spa, color: kThemeColour),
              title: Text('Groomers', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, GroomingSearchPage.id);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading:
                  Icon(FontAwesomeIcons.clinicMedical, color: kThemeColour),
              title: Text('Veterinarian', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, VetSearchPage.id);
              },
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.40),
              indent: 10.0,
              endIndent: 10.0,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.solidHeart, color: kThemeColour),
              title: Text('Wishlist', style: TextStyle(fontSize: 18)),
              onTap: () {
                //
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.boxOpen, color: kThemeColour),
              title: Text('Orders', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, OrderList.id);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.userAlt, color: kThemeColour),
              title: Text('Account', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, UserDetails.id);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: Icon(FontAwesomeIcons.powerOff, color: kThemeColour),
              title: Text('Log Out', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, AdoptionSearchPage.id);//
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '© 2021 Haztech',
                style: TextStyle(fontSize: 10),
              ),
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
  double windowWidth, windowHeight, statusBarHeight;
  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final adoption = Provider.of<DashboardProvider>(context);



    List<Widget> imageSliders = adoption.adoptionList.map((e) =>
    Container(
      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: EdgeInsets.only(bottom: 15.0, left: 5.0, right: 5.0),
                    child: InkWell(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            child: Image(
                              image: NetworkImage(
                                e.img1,
                              ),
                              fit: BoxFit.cover,
                              width: windowWidth * 0.70,
                              height: 500,
                            ),
                          ),
                          Center(
                            child: Container(
                              transform: Matrix4.translationValues(0, 100, 1),
                              decoration: BoxDecoration(
                                color: e.gender == 1
                                    ? Color(0xff263d7a)
                                    : Color(0xffFF5180),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                  e.gender == 1
                                      ? FontAwesomeIcons.mars
                                      : FontAwesomeIcons.venus,
                                  color: Colors.white,
                                  size: 18.0),
                            ),
                          ),
                        ],
                      ),

                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AdoptionPage.id,
                          arguments: e.adopt_id,
                        );
                      },
                    ),
                  ),

    )).toList();

    ///////////////////////////////////////////////


    final List<String> bestSellerList = [
      'https://i.pinimg.com/originals/06/27/45/0627456e97789d43cd0c7340aa2e4901.jpg',
      'https://c8.alamy.com/comp/KY1H61/sofia-bulgaria-may-05-2017-a-tin-of-pedigree-dog-food-dog-eating-from-KY1H61.jpg',
      'https://c8.alamy.com/comp/RKYC4X/moscow-russia-feb-122019-pedigree-dog-food-in-auchan-store-RKYC4X.jpg',
    ];

    final List<Widget> bestSellerSliders = bestSellerList
        .map((item) => Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: windowWidth * 0.70,
                    height: 500,
                  ),
                ),
              ),

            ))
        .toList();

    //home page appbar stater

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 55.0,
              width: windowWidth * 0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: kThemeColour,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: 35,
                      width: 35,
                      child: Center(
                        child: Container(
                          height: 20.0,
                          child: Image(
                            image: AssetImage('images/Svg1.png'),
                          ),
                        ),
                      ),
                    ),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        child: IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: new Icon(
                            FontAwesomeIcons.search,
                            color: kThemeColour,
                            size: 20,
                          ),
                          tooltip: 'Search',
                          onPressed: () {
                            //
                          },
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: new Icon(
                            FontAwesomeIcons.shoppingCart,
                            color: kThemeColour,
                            size: 20,
                          ),
                          tooltip: 'Cart',
                          onPressed: () {
                            Navigator.pushNamed(context, CartList.id);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: windowHeight - 55,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: windowWidth * 0.93,
                      child: Text(
                        'Find your favourite\nPet to adopt',
                        style: TextStyle(
                          fontSize: 20,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Pad(),
                    TitleBarWidget(
                        title: 'Adopt me', route: AdoptionSearchPage.id),
                    SizedBox(height: 5.0),
                    Container(
                      child:
                      adoption == null
                          ? Loadinggg() :
                           Column(
                              children: <Widget>[
                                CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 0.55,
                                    autoPlay: false,
                                    height: 220,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                  ),
                                  items: imageSliders,
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 15.0),
                    TitleBarWidget(
                        title: 'Best seller products',
                        route: EcommerceSearch.id),
                    SizedBox(height: 5.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 0.55,
                              autoPlay: false,
                              //aspectRatio: 3 / 4,
                              height: 190,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                            items: bestSellerSliders,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Banner(),
                    SizedBox(height: 15.0),
                    TitleBarWidget(title: 'Best seller products'),
                    SizedBox(height: 10.0),
                    Container(
                      width: windowWidth,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 5.0),
                            ProductContainer(
                              image: 'images/Img6.png',
                            ),
                            ProductContainer(
                              image: 'images/Img6.png',
                            ),
                            ProductContainer(
                              image: 'images/Img6.png',
                            ),
                            ProductContainer(
                              image: 'images/Img7.png',
                            ),
                            SizedBox(width: 5.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //carousel

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}

//home screen ends here

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: windowWidth,
      height: 120.0,
      width: MediaQuery.of(context).size.width * 0.93,
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: Color(0xfffea593),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                Text(
                  'Join today and save lives',
                  style: TextStyle(
                      color: kThemeColour,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Help the shelter to feed the pets',
                  style: TextStyle(
                    color: kThemeColour,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                    decoration: BoxDecoration(
                        color: Color(0xffff5180),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      'Donate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 110.0,
            child: Image(
              image: AssetImage('images/BannerDog.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleBarWidget extends StatelessWidget {
  TitleBarWidget({this.title, this.route});
  final String title, route;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: kThemeColour,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: Text(
                'View all',
                style: TextStyle(
                  fontSize: 16,
                  color: kThemeColour,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  ProductContainer({@required this.image, this.route});
  final String image, route;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Container(
          height: 130.0,
          width: 120.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          child: Image(
            image: AssetImage(image),
            //fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}

class Loadinggg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Row(
        children: [
          Container(
            height: 175.0,
            width: windowWidth * 0.20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(15.0)),
            ),
          ),
          SizedBox(width: windowWidth * 0.025),
          Container(
            height: 205.0,
            width: windowWidth * 0.55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          SizedBox(width: windowWidth * 0.025),
          Container(
            height: 175.0,
            width: windowWidth * 0.20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(15.0)),
            ),
          ),
        ],
      ),
    );
  }
}
