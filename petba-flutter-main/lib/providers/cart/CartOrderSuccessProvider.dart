import 'package:flutter/material.dart';
import 'package:petba/model/address.dart';

class CartOrderSuccessProvider extends ChangeNotifier {
  CartOrderSuccessProvider() {
    //
  }


  List<Address> address = [];


  fetchAddresses()async{
    const list = [];
    list.forEach((element) {
      address.add(Address.fromJson(element));
    });

  }
  bool isLoading = true;
  bool success = false;
  // TODO: if success, display success else display failed animation
}
