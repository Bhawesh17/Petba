import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petba/api/api_call.dart';
import 'package:petba/model/filter.dart';
import 'package:petba/model/filter_group.dart';

class FilterProvider extends ChangeNotifier {
  FilterProvider() {
    // fetchFilterGroup();
  }
  List<FilterData> filterData = [];
  List<FilterGroupData> filterGroupData = [];
  bool isLoadingGroup = true;
  bool isLoadingFilter = true;
  int filterGroupLength;

  //call starts here
  CallApi callApi = CallApi();

  fetchFilterGroup() async {
    filterGroupData = [];
    isLoadingGroup = true;
    final res = await callApi.get(url: '/product/filter_group');
    final jsonRes = jsonDecode(res.body);
    filterGroupLength = jsonRes.length;
    for (int i = 0; i < filterGroupLength; i++) {
      filterGroupData.add(FilterGroupData.fromJson(jsonRes[i]));
    }
    isLoadingGroup = false;
    fetchFilter(filterGroupData[0].groupId);
    notifyListeners();
  }

  fetchFilter(int filterId) async {
    isLoadingFilter = true;
    notifyListeners();

    filterData = [];
    final res = await callApi.get(url: '/product/filter/$filterId');
    final jsonRes = jsonDecode(res.body);
    for (int i = 0; i < jsonRes.length; i++) {
      filterData.add(FilterData.fromJson(jsonRes[i]));
    }
    for (int j = 0; j < filterGroupLength; j++) {
      if (filterGroupData[j].groupId == filterData[0].groupId) {
        filterGroupData[j].selected = true;
      } else {
        filterGroupData[j].selected = false;
      }
    }
    notifyListeners();

    isLoadingFilter = false;

    notifyListeners();
  }
}
