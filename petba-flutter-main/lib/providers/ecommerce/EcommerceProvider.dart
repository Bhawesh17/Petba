import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/ecommerce.dart';
import 'dart:convert';

class EcommerceProvider extends ChangeNotifier {
  EcommerceProvider() {
    // fetchProduct(50);
  }
  //
  //********RATING NEEDS TO BE PULLED FROM THE DATABASE*******//
  //
  bool isLoading = true, isWishlisted = false;
  Ecommerce productData;
  List<Category> category = [];
  List<double> rating = [];

  //
  CallApi callApi = CallApi();

  fetchProduct(int productId) async {
    isLoading = true;
    category = [];
    optionData = null;
    final res = await callApi.get(url: '/product/read/$productId');
    final jsonRes = jsonDecode(res.body);
    productData = Ecommerce.fromJson(jsonRes['product']);
    for (int i = 0;
        i < jsonRes['product']['product_option_category'].length;
        i++) {
      category.add(
          Category.fromJson(jsonRes['product']['product_option_category'][i]));
    }
    calRating();
    isLoading = false;
    notifyListeners();
  }

  calRating() {
    rating = [];
    double rate = 3.5;
    for (int i = 0; i < 5; i++) {
      if (rate > 0.5) {
        rating.add(1);
        rate -= 1;
      } else if (rate > 0) {
        rating.add(0.5);
        rate -= 1;
      } else {
        rating.add(0);
      }
    }
  }

  toggleWishlist(int id) async {
    var data = {
      'product_id': id,
    };
    if (productData.wishlist) {
      final res =
          await callApi.post(url: '/product/wishlist/remove', data: data);
      final jsonRes = jsonDecode(res.body);
      if (jsonRes['success']) {
        productData.wishlist = false;
      } else {
        print('Error in wishlistToggle');
      }
    } else {
      final res = await callApi.post(url: '/product/wishlist/add', data: data);
      final jsonRes = jsonDecode(res.body);
      if (jsonRes['success']) {
        productData.wishlist = true;
      } else {
        print('Error in wishlistToggle');
      }
    }
    notifyListeners();
  }

  resetSelected(int i, int id) {
    category.forEach((element) {
      for (int i = 0; i < element.isSelected.length; i++) {
        element.isSelected[i] = false;
      }
    });
    category[i].isSelected[id] = true;
    notifyListeners();
  }

  String optionData;

  addToCart(int id, int quantity) async {
    if (optionData == null) {
      print('Choose Option');
    } else {
      var data = {
        'product_id': id,
        'quantity': quantity,
        'option': optionData,
      };
      final res = await callApi.post(url: '/cart/add', data: data);
      if (res.statusCode == 200) {
        final jsonRes = jsonDecode(res.body);
        if (jsonRes['success'] == true) {
          print(jsonRes['message']);
        } else {
          print(jsonRes['message']);
        }
      } else {
        print('Login to continue');
      }
    }

    // print('success');
  }
}
