import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/constants.dart';
import 'package:petba/screens/adoption/adoption_screen.dart';
import 'package:petba/providers/adoption/AdoptionSearchProvider.dart';
import 'package:provider/provider.dart';
import 'package:petba/model/adoption.dart';
import 'package:shimmer/shimmer.dart';
import 'package:petba/screens/appbar.dart';

import 'adoption_add_screen.dart';

class AdoptionSearchPage extends StatefulWidget {
  static const String id = 'adoption_search_screen';
  @override
  _AdoptionSearchPageState createState() => _AdoptionSearchPageState();
}

class _AdoptionSearchPageState extends State<AdoptionSearchPage> {
  double windowHeight, windowWidth, statusBarHeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final adopt = Provider.of<AdoptionSearchProvider>(context, listen: false);
    adopt.isLoading = true;
    adopt.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;

    final adoption = Provider.of<AdoptionSearchProvider>(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          backgroundColor: kThemeColour,
          elevation: 2.0,
          child: Icon(FontAwesomeIcons.plus),
          onPressed: () {
            Navigator.pushNamed(context, AdoptionUploadScreen.id);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: "Dogs"),
            Container(
              height: windowHeight - 100,
              child: SingleChildScrollView(
                child: adoption.isLoading
                   ? LoadingPets() :
                Column(
                        children: [
                          SizedBox(
                            height: windowWidth * 0.015,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: adoption.adoptionSearchData.length,
                              itemBuilder: (context, i) {
                                final data = adoption.adoptionSearchData[i];
                                return AdoptContainer(
                                  adoptionData: data,
                                );
                              }),
                        ],
                      ),
              ),
            ),
            Container(
              height: 45,
              color: kThemeColour,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Sort',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 45,
                    color: Color(0xffababab).withOpacity(0.5),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 45,
                    color: Color(0xffababab).withOpacity(0.5),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Center(
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, route);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AdoptContainer extends StatelessWidget {
  AdoptContainer({this.adoptionData});
  AdoptionData adoptionData;

  checkInjection() {
    if (adoptionData.antiRabies) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffDCDCDC),
              width: 0.8,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        height: 30,
        width: 30,
        child: Icon(
          FontAwesomeIcons.syringe,
          color: kThemeColour,
          size: 15.0,
        ),
      );
    } else
      return SizedBox(width: 34);
  }

  @override
  Widget build(BuildContext context) {
    final adoptionSearchProvider = Provider.of<AdoptionSearchProvider>(context);
    final windowWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(vertical: windowWidth * 0.015, horizontal: windowWidth * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kThemeColour.withOpacity(0.10),
              blurRadius: 6.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                height: 120,
                width: 160,
                image: NetworkImage(adoptionData.images[0]),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 190,
              padding: const EdgeInsets.only(left: 9, right: 9, top: 0, bottom: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adoptionData.name,
                    style: TextStyle(
                      fontSize: 17,
                      color: kThemeColour,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Age: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        adoptionData.age,
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Breed: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 250,
                        child: Text(
                          adoptionData.breed, //// data base data
                          style: TextStyle(
                            fontSize: 13,
                            color: kThemeColour,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "City: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 250,
                        child: Text(
                          adoptionData.city, //// data base data
                          style: TextStyle(
                            fontSize: 13,
                            color: kThemeColour,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: adoptionData.gender == 1 ? Color(0xff263d7a) : Color(0xffff5180),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          height: 30,
                          width: 30,
                          child: adoptionData.gender == 1
                              ? Icon(
                                  FontAwesomeIcons.mars,
                                  color: Colors.white,
                                  size: 15.0,
                                )
                              : Icon(
                                  FontAwesomeIcons.venus,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        checkInjection(),
                        Expanded(child: Text('')),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDCDCDC),
                                width: 0.8,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          height: 30,
                          width: 30,
                          child: InkWell(
                            child: Icon(
                              FontAwesomeIcons.solidHeart,
                              size: 15,
                              color: adoptionData.wishlist ? Color(0xfffea593) : Color(0xffe0e0e0),
                            ),
                            onTap: () {
                              adoptionSearchProvider.toggleWishlist(adoptionData.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AdoptionPage.id,
          arguments: adoptionData.id,
        );
      },
    );
  }
}

class LoadingPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: [
          for (int i = 0; i < 6; i++)
            (Container(
              height: 120,
              margin: EdgeInsets.symmetric(vertical: windowWidth * 0.015, horizontal: windowWidth * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
            )),
        ],
      ),
    );
  }
}
