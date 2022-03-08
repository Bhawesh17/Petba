import 'package:flutter/material.dart';
import 'package:petba/model/user.dart';

class LogProvider extends ChangeNotifier {
  var name = "Hello!";

  List<UserData> user = [];

  fetchUserData() {
    for (Map i in users) {
      user.add(UserData.fromJson(i));
    }

    user.forEach((element) {
      print(element.id);
    });
  }

  changeName() {
    name = "Kitty";
    notifyListeners();
  }
}

final users = [
  {"id": 1, "name": "sdsdfsdf", "email": "sdfsdfsdfsdf"},
  {"id": 2, "name": "sdsdfsdf", "email": "sdfsdfsdfsdf"},
  {"id": 3, "name": "sdsdfsdf", "email": "sdfsdfsdfsdf"},
  {"id": 4, "name": "sdsdfsdf", "email": "sdfsdfsdfsdf"}
];
