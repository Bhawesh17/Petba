import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsProvider() {
     fetchUserDetails();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String email, phone;
  bool isLoading = true, isLoadingButton = false;
  CallApi callApi = CallApi();

  fetchUserDetails() async {
    isLoading = true;
    notifyListeners();

    final res = await callApi.get(url: '/user_details');
    if (res.statusCode == 200) {
      final jsonRes = jsonDecode(res.body);
      firstName = TextEditingController(text: jsonRes['firstname']);
      lastName = TextEditingController(text: jsonRes['lastname']);
      phone = jsonRes['telephone'];
      email = jsonRes['email'];
      isLoading = false;
    } else {
      print('Login to continue');
    }

    notifyListeners();
  }

  pushUserDetails() async {
    isLoadingButton = true;
    notifyListeners();
    var data = {
      'firstname': firstName.text,
      'lastname': lastName.text,
    };
    final res = await callApi.post(url: '/user_details', data: data);
    print('res');
    final jsonRes = jsonDecode(res.body);
    if (jsonRes['success']) {
      print('Success');
    } else {
      print('Update Failed');
    }
    isLoadingButton = false;
    notifyListeners();
  }
}
