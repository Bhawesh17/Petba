import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/ecommerce.dart';

class EcommerceSearchProvider extends ChangeNotifier {
  EcommerceSearchProvider() {
   // fetchProduct();
  }

  bool isLoading = true;
  List<Ecommerce> productSearchData = [];

  //
  CallApi callApi = CallApi();

  fetchProduct() async {
    productSearchData = [];
    isLoading = true;
    final res = await callApi.get(url: '/product');
    final jsonRes = jsonDecode(res.body);
    if (jsonRes['success']) {
      for (int i = 0; i < jsonRes['products'].length; i++) {
        productSearchData.add(Ecommerce.fromJson(jsonRes['products'][i]));
      }
      isLoading = false;
    } else {
      print(jsonRes['message']);
    }

    notifyListeners();
  }
}
