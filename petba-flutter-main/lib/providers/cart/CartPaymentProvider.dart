import 'dart:convert';
import 'package:petba/api/api_call.dart';
import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:petba/model/address.dart';

class CartPaymentProvider extends ChangeNotifier {
  CartPaymentProvider() {
    fetchActiveAddress(3);
  }
  int radioButton = 1;
  bool isLoadingAddress = true;
  bool isLoadingAddressList = true;
  bool isLoadingOrderSuccess = false;
  Address address;
  List<Address> addressList = [];

  changeAddress(Address add) {
    address = add;
    notifyListeners();
  }

  //call starts here
  CallApi callApi = CallApi();

  fetchActiveAddress(id) async {
    isLoadingAddress = true;
    notifyListeners();
    final res = await callApi.get(url: '/address/$id');
    final jsonRes = jsonDecode(res.body);
    address = Address.fromJson(jsonRes['address']);
    isLoadingAddress = false;
    notifyListeners();
  }

  fetchAddressList() async {
    isLoadingAddressList = true;
    notifyListeners();
    addressList = [];
    final res = await callApi.get(url: '/address');
    final jsonRes = jsonDecode(res.body);
    for (int i = 0; i < jsonRes['address'].length; i++) {
      addressList.add(Address.fromJson(jsonRes['address'][i]));
    }
    isLoadingAddressList = false;
    notifyListeners();
  }

  Future<bool> pushToDb(double total) async {
    isLoadingOrderSuccess = true;
    notifyListeners();
    print(address.addressId);
    var data = {
      'address_id': address.addressId,
      'payment_id': radioButton,
      'total': total,
    };
    print('here');
    final res = await callApi.post(url: '/order', data: data);
    final jsonRes = jsonDecode(res.body);
    print(jsonRes);
    isLoadingOrderSuccess = false;
    notifyListeners();
    return jsonRes['success'];
  }
}
