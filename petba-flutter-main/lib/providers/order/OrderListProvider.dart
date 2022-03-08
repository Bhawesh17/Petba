import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/order.dart';

class OrderListProvider extends ChangeNotifier {
  OrderListProvider() {
    // fetchOrderList();
  }
  bool isLoading = true;
  List<OrderData> orderData = [];
  //
  CallApi callApi = CallApi();

  fetchOrderList() async {
    isLoading = true;
    orderData = [];

    //Call to Laravel Api to get order list
    final res = await callApi.get(url: '/order');

    if (res.statusCode == 200) {
      final jsonRes = jsonDecode(res.body);
      //Add the data to adoptionData using factory in the model
      for (int i = 0; i < jsonRes['order'].length; i++) {
        for (int j = 0; j < jsonRes['order'][i]['order_products'].length; j++) {
          // Passing the products, the order status and the date added
          orderData.add(OrderData.fromJson(jsonRes['order'][i]['order_products'][j],
              jsonRes['order'][i]['order_status_id'], jsonRes['order'][i]['date_added']));
          // print(jsonRes['order'][i]['order_products']);
        }
      }
    } else {
      print('Login to continue');
    }

    isLoading = false;
    notifyListeners();
  }
}
