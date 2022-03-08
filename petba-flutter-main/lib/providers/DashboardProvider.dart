import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/adoption.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class BestSellerData {
  final String image;
  final int id;
  BestSellerData({this.image, this.id});
}

class DashboardProvider extends ChangeNotifier {
  //the pet data
  DashboardProvider() {
    fetchAdoption();
  }
  List<dataa> adoptionList = [];

  bool isLoading = true;

  CallApi callApi = CallApi();

  fetchAdoption() async {
    isLoading = true;
    adoptionList = [];
    print("Bhawesh provider file ////////////////////////////////////////////////");
    var res = await http.get("http://192.168.43.10/petba/public/api/dashboard/adoption");
  //  var res = await CallApi().post(url:'/dashboard/adoption');
    final jsonRes = jsonDecode(res.body);
    print(jsonRes);
    for (var dat in jsonRes) {
      adoptionList.add(new dataa
        (dat['img1'], dat['gender'] ,dat['adopt_id'], dat['name'], dat['breedName'], dat['dob']));
    }
    print("Bhawesh provider file ////////////////////////////////////////////////");

    adoptionList.map((element) {
        print("img1 : ${element.img1}");
        print("gender : ${element.gender}");
        print('id : ${element.adopt_id}');
      }).toList();
      // for (int i = 0; i < jsonRes.length; i++) {
    //   adoptionList.add(AdoptionData.fromJson(jsonRes[i]));
    // }

   // addImages();        //http://192.168.43.10/petba/public/api/dashboard/adoption
    isLoading = false;    //http://www.petba.in/
    notifyListeners();
  }

  List<String> adoptionListImages = [];

  // addImages() {
  //   adoptionListImages = [];
  //   for (int i = 0; i < adoptionList.length; i++) {
  //     adoptionListImages.add(adoptionList[i].images[0]);
  //    // print(adoptionListImages[i]);
  //   }
  // }

  final List<String> bestSellerList = [
    'https://i.pinimg.com/originals/06/27/45/0627456e97789d43cd0c7340aa2e4901.jpg',
    'https://c8.alamy.com/comp/KY1H61/sofia-bulgaria-may-05-2017-a-tin-of-pedigree-dog-food-dog-eating-from-KY1H61.jpg',
    'https://c8.alamy.com/comp/RKYC4X/moscow-russia-feb-122019-pedigree-dog-food-in-auchan-store-RKYC4X.jpg',
  ];

  List<BestSellerData> bestSellerData = [
    BestSellerData(
      id: 1,
      image: 'https://i.pinimg.com/originals/06/27/45/0627456e97789d43cd0c7340aa2e4901.jpg',
    ),
    BestSellerData(
      id: 1,
      image:
          'https://c8.alamy.com/comp/KY1H61/sofia-bulgaria-may-05-2017-a-tin-of-pedigree-dog-food-dog-eating-from-KY1H61.jpg',
    ),
    BestSellerData(
      id: 1,
      image:
          'https://c8.alamy.com/comp/RKYC4X/moscow-russia-feb-122019-pedigree-dog-food-in-auchan-store-RKYC4X.jpg',
    ),
  ];
}
