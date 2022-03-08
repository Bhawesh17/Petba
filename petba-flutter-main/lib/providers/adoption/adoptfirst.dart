import 'dart:convert';

import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/model/adoption.dart';
import 'package:petba/screens/adoption/adoption_add_screen.dart';
import 'package:petba/screens/adoption/adoption_screen.dart';

//import 'package:petba/screens/adoption/adoption_search_screen.dart';
import 'package:petba/screens/appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'AdoptionSearchProvider.dart';
import '../../constants.dart';

class adapt extends StatefulWidget {
  static const String id = 'adoptfirst';
  @override
  _adaptState createState() => _adaptState();
}

class _adaptState extends State<adapt> {
  List datas = [];
  List image = [
    'http://192.168.43.10/petba/public/images/Logo.png',
  ];
  int igo = 2;

  bool isLoading = false;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   this.fetchdata();
  // }

  List<show> adoptionList = [];
  extractdata adoptdata;

  // fetchdata() async {
  //   var url = "http://192.168.43.10/petba/public/api/adopt";
  //   var resp = await http.get(url);
  //   print(resp.statusCode);
  //   if (resp.statusCode == 200) {
  //     var data = json.decode(resp.body);
  //     print(data);
  //     setState(() {
  //       datas = data;
  //       for (var dat in data) {
  //         adoptionList.add(show.fromJson(dat));
  //       }
  //     });
  //     print('here');
  //     // for (var dat in data) {
  //     //   adoptionList.add(show.fromJson(dat));
  //     // }
  //
  //     for (var dat in adoptionList) {
  //       print("new from list");
  //       print(dat.id);
  //     }
  //
  //     // adoptionList.map((element) {
  //     //   print("img1 : ${element.img1}");
  //     //   print("gender : ${element.gender}");
  //     //   print('id : ${element.adopt_id}');
  //     // }).toList();
  //
  //   } else {
  //     print('this is proble');
  //     setState(() {
  //       datas = [];
  //     });
  //   }
  // }

  @override

  Widget build(BuildContext context) {
    final adoption = Provider.of<AdoptionSearchProvider>(context);
    return SafeArea(
      child: Scaffold(
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
        body: Column(
          children: [
            AppBarWidget(title: "Dogs"),
            Expanded(
              child: ListView.builder(
                  itemCount: adoption.adoptionList.length,
                  itemBuilder: (context, i) {
                    final data = adoption.adoptionList[i];
                    return AdoptContainer(
                      adoptdata: data,
                    );
                  }),
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


class AdoptContainer extends StatelessWidget {
  AdoptContainer({ this.adoptdata });

show adoptdata;

  @override
  Widget build(BuildContext context) {

    final windowWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(
            vertical: windowWidth * 0.015, horizontal: windowWidth * 0.03),
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
                image: NetworkImage(
                  adoptdata.img1.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 190,
              padding:
              const EdgeInsets.only(left: 9, right: 9, top: 0, bottom: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adoptdata.name.toString(),
                    style: TextStyle(
                      fontSize: 17,
                      color: kThemeColour,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Animal: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 270,
                        child: Text(
                          //adoptionData.breed
                          adoptdata.animal, //// data base data
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
                        "Age: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        //adoptionData.age
                        calAge(adoptdata.dob),
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
                          //adoptionData.breed
                          adoptdata.breed, //// data base data
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
                            color:adoptdata.gender == 1
                                ? Color(0xff263d7a)
                                : Color(0xffff5180),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          height: 30,
                          width: 30,
                          child: adoptdata.gender == 1
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
                        // checkInjection(),
                        Expanded(child: Text('')),
                       Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffDCDCDC),
                                width: 0.8,
                              ),
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          height: 30,
                          width: 30,
                          child: InkWell(
                            child: Icon(
                              FontAwesomeIcons.solidHeart,
                              size: 15,
                              color: Color(0xffe0e0e0),
                            ),
                            onTap: () {},
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
          arguments: adoptdata.id,
        );
      },
    );
  }

  String calAge(String dob) {
    DateTime parseDt = DateTime.parse(dob);
    DateTime birthday = DateTime(parseDt.year, parseDt.month, parseDt.day);
    DateTime today = DateTime.now(); //2020/1/24
    AgeDuration age;
    // Find out your age
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    if (age.years == 1) {
      return '${age.years} year';
    } else if (age.years > 1) {
      return '${age.years} years';
    } else if (age.months == 1) {
      return '${age.months} month';
    } else if (age.months > 1) {
      return '${age.months} months';
    } else {
      return '${age.days} days';
    }
  }
  }
//}
