import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/zone.dart';

class CartAddressNewProvider extends ChangeNotifier {
  CartAddressNewProvider() {
    fetchZone();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  List<String> zone = ['-State-'];
  List<Zone> zoneData = [];
  String zoneValue = '-State-';

  bool isLoading = true;
  bool buttonSelected = false;
  bool goToPreviousScreen = false;

  CallApi callApi = CallApi();

  void fetchZone() async {
    isLoading = true;
    notifyListeners();
    zone = ['-State-'];
    zoneValue = '-State-';
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    pincodeController.clear();
    addressController.clear();
    cityController.clear();
    final res = await callApi.get(url: '/zone/99');
    final jsonRes = jsonDecode(res.body);
    for (int i = 0; i < jsonRes.length; i++) {
      zoneData.add(Zone.fromJson(jsonRes[i]));
      zone.add(jsonRes[i]['name']);
    }
    isLoading = false;
    notifyListeners();
  }

  addAddress() async {
    buttonSelected = true;
    notifyListeners();
    int zoneId;
    zoneData.forEach((element) {
      if (element.name == zoneValue) {
        zoneId = element.id;
      }
    });
    if (zoneId != null) {
      var data = {
        'firstname': firstNameController.text,
        'lastname': lastNameController.text,
        'phone': phoneController.text,
        'postcode': pincodeController.text,
        'address': addressController.text,
        'city': cityController.text,
        'zone_id': zoneId,
      };

      final res = await callApi.post(url: '/address', data: data);
      final jsonRes = jsonDecode(res.body);
      buttonSelected = false;
      notifyListeners();
      if (res.statusCode == 200) {
        final jsonRes = jsonDecode(res.body);
        if (jsonRes['success']) {
          print('Added!');
          goToPreviousScreen = true;
          notifyListeners();
        } else {
          print(jsonRes);
        }
      } else {
        print('Login to continue');
      }
    } else {
      print('Choose STATE!!');
    }
  }
}
