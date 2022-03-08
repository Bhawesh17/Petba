import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/cart.dart';

class CartListProvider extends ChangeNotifier {
  CartListProvider() {
    fetchCartData();
  }
  List<Cart> cartProducts = [];
  bool isLoading = true, isLoadingQuantity = false;
  double total = 0.0, deliveryCharges = 0.0;
  int numberOfItems, tax = 0;

  //call starts here
  CallApi callApi = CallApi();

  fetchCartData() async {
    isLoading = true;
    notifyListeners();
    cartProducts = [];
    final res = await callApi.get(url: '/cart');
    final jsonRes = jsonDecode(res.body);
    for (int i = 0; i < jsonRes['cart'].length; i++) {
      cartProducts.add(Cart.fromJson(jsonRes['cart'][i]));
    }
    //print(cartProducts[1].productId);
    calTotal();
    isLoading = false;
    notifyListeners();
  }

  quantityUpdate(productId, quantity) async {
    isLoadingQuantity = true;
    notifyListeners();
    var data = {
      'product_id': productId,
      'quantity': quantity,
    };
    await callApi.post(url: '/cart/quantity', data: data);
    //To refresh
    cartProducts = [];
    final res = await callApi.get(url: '/cart');
    final jsonRes = jsonDecode(res.body);
    for (int i = 0; i < jsonRes['cart'].length; i++) {
      cartProducts.add(Cart.fromJson(jsonRes['cart'][i]));
    }
    calTotal();
    isLoadingQuantity = false;
    notifyListeners();
  }

  removeItem(int productId) async {
    isLoading = true;
    notifyListeners();
    var data = {
      'product_id': productId,
    };
    await callApi.post(url: '/cart/remove', data: data);
    calTotal();
    isLoading = false;
    notifyListeners();
  }

  calTotal() {
    deliveryCharges = 50;
    total = 0.0;
    tax = 0;
    cartProducts.forEach((element) {
      total += element.price;
    });
    tax = (total * 0.18).toInt();
    total += deliveryCharges;
  }
}
