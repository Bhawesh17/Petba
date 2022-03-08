import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/adoption.dart';
import 'package:age/age.dart';

class AdoptionSearchProvider extends ChangeNotifier {
  //
  AdoptionSearchProvider() {
    fetchData();
  }

  List<AdoptionData> adoptionSearchData = [];
  List<show> adoptionList = [];
  bool isLoading = true;

  //call starts here
  CallApi callApi = CallApi();
//collect data from database
  fetchData() async {
    adoptionSearchData = [];
    final res = await callApi.get(url: '/adopt');     //full link http://192.168.43.10/petba/public/api/adopt
  //  final jsonRes = jsonDecode(res.body);
    print(res);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
        for (var dat in data) {
          adoptionList.add(show.fromJson(dat));
        }
      print('here');
      // for (var dat in data) {
      //   adoptionList.add(show.fromJson(dat));
      // }

      for (var dat in adoptionList) {
        print("new from list");
        print(dat.id);
      }

      // adoptionList.map((element) {
      //   print("img1 : ${element.img1}");
      //   print("gender : ${element.gender}");
      //   print('id : ${element.adopt_id}');
      // }).toList();

    } else {
      print('this is proble');
    }
    isLoading = false;
    notifyListeners();
  }
//////////////////////////////////
  calAge(dob) {
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

  toggleWishlist(int id) {
    //pass the customer_id and item_id and change the wishlist in the db
    var data = {
      'adopt_id': id,
    };
    adoptionSearchData.forEach((element) async {
      if (element.id == id) {
        if (element.wishlist) {
          final res =
              await callApi.post(url: '/adopt/wishlist/remove', data: data);
          if (res.statusCode == 200) {
            element.wishlist = false;
          } else {
            print('Login to continue');
          }
          notifyListeners();
        } else {
          final res =
              await callApi.post(url: '/adopt/wishlist/add', data: data);
          print(jsonDecode(res.body));
          if (res.statusCode == 200) {
            element.wishlist = true;
          } else {
            print('Login to continue');
          }
          notifyListeners();
        }
      }
    });
  }
}
