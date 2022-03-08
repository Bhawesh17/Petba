import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petba/model/adoption.dart';
import 'package:petba/screens/appbar.dart';
import '../../constants.dart';
import 'package:petba/providers/adoption/AdoptionProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
///////////////////////
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdoptionPage extends StatefulWidget {
  static const String id = 'adoption_page';
  @override
  _AdoptionPageState createState() => _AdoptionPageState();
}


class _AdoptionPageState extends State<AdoptionPage> {
  int _current = 0;
  int current = 0;
  double windowHeight, windowWidth, statusBarHeight;
  int id;
  List work;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callFunction();
    flag();
  }


  // callFunction() async {
  //   // final adoption = Provider.of<AdoptionProvider>(context, listen: false);
  //   // adoption.isLoading = true;
  //    await id;
  //   // adoption.fetchAdoption(id);
  //   await flag(id);
  //   print('inside $id');
  //
  //   //fetchAdoption(id);
  // }

  extractdata adoptdata;

  flag() async {
    await id;
    // images.add(adoptdata.success.toString());
    var res = await http.get(
        'http://192.168.43.10/petba/public/api/adopt/read/$id');
    if (res.statusCode == 200) {
      final jsonRes = json.decode(res.body);
      print(jsonRes);
      setState(() {
        current = 1;
        adoptdata = extractdata.fromJson(jsonRes);
        images();
        // print(me);
      });

      //  print('gender: ${adoptdata.adopt.gender }');
      print(adoptdata.adopt.ownerdp);
    } else {
      print('Some Error happened');
    }
  }

  List me = [];
  List<String> slideimage = [];

  images() {
    me.add(adoptdata.adopt.img1);
    me.add(adoptdata.adopt.img2);
    me.add(adoptdata.adopt.img3);
    me.add(adoptdata.adopt.img4);
    print(me);
    for (int i = 0; i < 4; i++) {
      if (me[i] != "") {
        slideimage.add(me[i]);
      } else {
        print('this the problem');
      }
    }
    print(slideimage);
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute
        .of(context)
        .settings
        .arguments;
    print('m''e');
    print(id);


    statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    windowHeight = MediaQuery
        .of(context)
        .size
        .height - statusBarHeight;
    windowWidth = MediaQuery
        .of(context)
        .size
        .width;
    final adoption = Provider.of<AdoptionProvider>(context);
    // print(adoption.adoptdata.success);
    final List<Widget> imageSliders = slideimage.map(
          (item) =>
          Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item.toString(),
                        fit: BoxFit.cover,
                        height: 200,
                        width: windowWidth,
                      ),
                    ],
                  )),
            ),
          ),
    )
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(title: "Adoption", width: 150),
            Container(
              height: windowHeight - 55,
              child: SingleChildScrollView(
                child:
                //adoption.isLoading
                current != 1
                    ? LoadingPet() :
                Column(
                  children: [
                    CarouselSlider(
                      items: imageSliders,
                      options: CarouselOptions(
                          viewportFraction: 1.0,
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    //SizedBox(height: 100.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: slideimage.map((url) {
                        int index = slideimage.indexOf(url);
                        return AnimatedContainer(
                          //margin: EdgeInsets.symmetric(horizontal: 10.0),
                          width: _current == index ? 22.0 : 12.0,
                          height: 6.0,
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 3.0),
                          decoration: BoxDecoration(
                            //shape: _current == index ? BoxShape.circle : BoxShape.rectangle,
                            color: _current == index
                                ? Color(0xffFEA593)
                                : Color(0xffE1E7F6),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoButton(
                              gender: adoptdata.adopt.gender),
                          InfoButton(),
                          InfoButton(
                              injection:
                              true),
                          InfoButton(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: windowWidth * 0.93,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            adoptdata.adopt.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: kThemeColour,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                size: 16,
                                color: Color(0xffFEA593),
                              ),
                              // Text(
                              //   ' ' +
                              //       adoptionData.address.locality +
                              //       ', ' +
                              //       adoption.adoptionData.address.adminArea,
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: kThemeColour,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: windowWidth * 0.93,
                      child: Row(
                        children: [
                          Text(
                            "Age :  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: kThemeColour,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            //   adoption.adoptionData.age, //data base data
                            calAge(adoptdata.adopt.dob),
                            style: TextStyle(
                              fontSize: 14,
                              color: kThemeColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: windowWidth * 0.93,
                      child: Row(
                        children: [
                          Text(
                            "Breed :  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: kThemeColour,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            adoptdata.adopt.breed, //// data base data
                            style: TextStyle(
                              fontSize: 14,
                              color: kThemeColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: windowWidth * 0.93,
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                adoptdata.adopt.ownerdp,
                                scale: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: windowWidth * 0.72,
                            child: Text(
                             adoptdata.adopt.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: kThemeColour,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: windowWidth * 0.93,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                color: kThemeColour,
                              ),
                              child: Text(
                                "Meet the pet",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffDCDCDC),
                                  width: 0.8,
                                ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              height: 40,
                              width: 40,
                              child: WishlistIcon(
                                  wishlist:adoptdata.adopt.wishlist),
                            ),
                            onTap: () {
                              //toggleWishlist(adoption.adoptionData.id);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            //////////////////////////////
          ],
        ),
      ),
    );
  }

   calAge(dob) {
    DateTime parseDt = DateTime.parse(dob);
    DateTime birthday = DateTime(parseDt.year, parseDt.month, parseDt.day);
    DateTime today = DateTime.now(); //2020/1/24

    AgeDuration age;

    //Take current date and
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);

    //If a year old so then show years and similarly months or days
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

  void toggleWishlist(id) {}
}




class WishlistIcon extends StatelessWidget {
  WishlistIcon({this.wishlist});
  final bool wishlist;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesomeIcons.solidHeart,
      size: 20,
      color: wishlist ? Color(0xffFEA593) : Color(0xffDCDCDC),
    );
  }
}

class InfoButton extends StatelessWidget {
  InfoButton({this.gender, this.injection});
  final int gender;
  final bool injection;
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<AdoptionProvider>(context);
    info.resetIconData();
    info.checkIconData(gender, injection);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: gender == null
                  ? Border.all(
                      color: Color(0xffDCDCDC),
                      width: 0.0,
                    )
                  : null,
              color: info.bgColour,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 40,
          width: 40,
          child: Icon(info.iconData, color: info.iconColour, size: 20),
        ),
        SizedBox(height: 5.0),
        Text(
          info.title,
          style: TextStyle(
            fontSize: 11,
            color: kThemeColour,
          ),
        ),
      ],
    );
  }
}

class LoadingPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.0),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Container(
              width: 70,
              height: 7.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 50,
                  width: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 50,
                  width: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 50,
                  width: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Container(
                  height: 15.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: 14.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          SizedBox(height: 15.0),
          Container(
            height: 14.0,
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Column(
                  children: [
                    Container(
                      height: 8.0,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 8.0,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 8.0,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
