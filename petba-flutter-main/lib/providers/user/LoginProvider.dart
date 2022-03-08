import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petba/api/api_call.dart';
import 'package:petba/screens/dashboard_screen.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  //
  void loginCheckData(context) async {
    var data = {
      'email': loginEmailController.text,
      'password': loginPasswordController.text,
    };

    http.Response res = await CallApi().post(url:'/login',data:data);
     loginPasswordController.clear();
    if (res.statusCode == 200) {
      bool success = jsonDecode(res.body)['success'];
      if (success) {
        Navigator.pushNamed(context, HomePage.id);
      } else {
        var snack = jsonDecode(res.body)['error']['email'];
        if (snack == null) {
          snack = jsonDecode(res.body)['error']['password'];
          print(snack);
        }
        snack = snack.join();
        //The error message is a list so first convert it into strings
        final snackBar = SnackBar(content: Text(snack));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } else if (res.statusCode == 401) {
      String snack = jsonDecode(res.body)['error'];
      final snackBar = SnackBar(content: Text(snack));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      print('Error');
    }
   // Navigator.pushNamed(context, HomePage.id);
  }
}
