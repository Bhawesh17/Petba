import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petba/api/api_call.dart';
import 'package:petba/screens/dashboard_screen.dart';

class RegistrationProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //

  CallApi callApi = CallApi();
  void registerCheckData(context) async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
    };

    http.Response res = await callApi.post(url: '/register', data: data);
    passwordController.clear();
    if (res.statusCode == 200) {
      bool success = jsonDecode(res.body)['success'];
      if (success) {
        final snackBar = SnackBar(content: Text('Login to continue'));
        Scaffold.of(context).showSnackBar(snackBar);
        Navigator.pushNamed(context, HomePage.id);
      } else {
        //todo: here to add;
        var snack = jsonDecode(res.body)['error']['name'];
        if (snack == null) {
          snack = jsonDecode(res.body)['error']['email'];
          if (snack == null) {
            snack = jsonDecode(res.body)['error']['password'];
            if (snack == null) {
              snack = jsonDecode(res.body)['error']['phone'];
            }
          }
        }
        snack = snack.join();
        final snackBar = SnackBar(content: Text(snack));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } else if (res.statusCode == 401) {
      final snackBar =
          SnackBar(content: Text('Email not available, already registered'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      print('Error');
    }
  }
}
