import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/api/api_call.dart';
import '../../constants.dart';
import 'package:petba/model/adoption.dart';
import 'package:age/age.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

class AdoptionProvider extends ChangeNotifier {
  // AdoptionProvider() {
  //  // fetchAdoption(71);
  // }

  //the pet data

  AdoptionData adoptionData;

  extractdata adoptdata;
List me;
  bool isLoading = true;

  //call starts here
  CallApi callApi = CallApi();


  fetchAdoption(int id) async {
    //Call to Laravel Api to get individual pet data
    var res = await http.get(
        'http://192.168.43.10/petba/public/api/adopt/read/$id');
    //final res = await callApi.get(url: '/adopt/read/$id');
    if (res.statusCode == 200) {
      // final jsonRes = json.decode(res.body);
      // print(jsonRes);
      //
      // adoptdata = extractdata.fromJson(jsonRes);
      //
      // //print('gender: ${adoptdata.success }');
      //
      // print('gender: ${adoptdata.adopt.ad_id }');

      //
      //
      // saver();
      // // // Add the data to adoptionData using factory in the model
      // adoptionData = AdoptionData.fromJson(jsonRes);
      // print('here below');
      // print(adoptionData.gender);
      // adoptionData.age = await calAge(adoptionData.dob);
      // adoptionData.address = await getLocation();
      // addImages();
      // isLoading = false;
    } else {
      print('Some Error happened');
    }

    notifyListeners();
  }
  List<dynamic> detals;
  saver() {
    //detals.add(adoptdata.success);

  }


  //all the pet images will come here
  List<String> images = [];

  //To pull the images from the model and add it to a separate list to use in a carousel
  addImages() {
    images = [];
    for (int i = 0; i < 4; i++) {
      if (adoptionData.images[i] != "") {
        images.add(adoptionData.images[i]);
      } else {
        print('this the problem');
      }
    }
  }

  //Pet location is stored in lat, long.. so to convert that to an address
  getLocation() async {
    final coordinates =
    new Coordinates(adoptionData.latitude, adoptionData.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  //Based on dob to cal the pet age
  calAge(dob) {
    //To parse the dob into year, month, etc
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

  //to move between add to wishlist or not
  toggleWishlist(int id) async {
    var data = {
      'adopt_id': id,
    };
    if (adoptionData.wishlist) {
      final res = await callApi.post(url: '/adopt/wishlist/remove', data: data);
      if (res.statusCode == 200) {
        adoptionData.wishlist = false;
      } else {
        print('Login to continue');
      }
      notifyListeners();
    } else {
      final res = await callApi.post(url: '/adopt/wishlist/add', data: data);
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        adoptionData.wishlist = true;
      } else {
        print('Login to continue');
      }
      notifyListeners();
    }
  }

  IconData iconData;
  Color bgColour = Colors.white,
      iconColour = kThemeColour;
  String title = '';

  //have to reset the values before check data otherwise mess is happening
  resetIconData() {
    iconData = null;
    bgColour = Colors.white;
    iconColour = kThemeColour;
    title = '';
  }

  //this will display the Icon data based on the data passed
  checkIconData(gender, antiRabis) {
    if (gender == 1) {
      bgColour = Color(0xff263d7a);
      iconColour = Colors.white;
      iconData = FontAwesomeIcons.mars;
      title = 'Male';
    } else if (gender == 2) {
      bgColour = Color(0xffff5180);
      iconColour = Colors.white;
      iconData = FontAwesomeIcons.venus;
      title = 'Female';
    } else {
      if (antiRabis == true) {
        iconData = FontAwesomeIcons.syringe;
      } else if (antiRabis == false) {
        iconData = FontAwesomeIcons.skullCrossbones;
        iconColour = Colors.red;
        title = 'Change';
      }
    }
  }

}


