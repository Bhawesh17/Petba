// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiCall {
//   //final String _baseUrl = 'http://192.168.43.198/petba/public/api';
//   final String _baseUrl = 'http://192.168.31.69/petba/public/api';
//   // final String _baseUrl = 'http://192.168.43.198:8000/api';
//
//   postData(data, apiUrl) async {
//     String fullUrl = _baseUrl + apiUrl;
//     return await http.post(
//       fullUrl,
//       body: jsonEncode(data),
//       headers: _setHeader(),
//     );
//   }
//
//   getData(apiUrl) async {
//     String fullUrl = _baseUrl + apiUrl;
//     return await http.get(
//       fullUrl,
//       headers: _setHeader(),
//     );
//   }
//
//   _setHeader() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import '../constants.dart';
import 'connection.dart';

class CallApi {
  InternetConnection _internetConnection = InternetConnection.getInstance();
  ConnectionStatus _connectionResponse;

  static String _ip = serverIp + "/petba/public/api";
  static String _id = "/user_id=1";

  Future<http.Response> post({String url, data, Function onConnectionFailed}) async {
    _connectionResponse = await _internetConnection.status();
    if (_connectionResponse.status == ConnectionStatus.online) {
    String fullUrl = _ip + url;//can add _id   //http://192.168.43.10/petba/public/api/login/user_id=1
    http.Response res = await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeader(),
    );
    return res;
    } else {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => onConnectionFailed());
    }
  }

  multipart(
      {String url,
      data,
      List<http.MultipartFile> files,
      Function onConnectionFailed}) async {
    String fullUrl = _ip + url;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(fullUrl),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    files.forEach((element) {
      request.files.add(element);
    });

    request.headers.addAll(headers);
    request.fields.addAll(data);
    print("request: " + request.toString());

    var res = await request.send();

    print("This is response:" + res.toString());
    final respStr = await res.stream.bytesToString();
    return respStr;
  }

  get({String url, Function onConnectionFailed}) async {
    _connectionResponse = await _internetConnection.status();
    if (_connectionResponse.status == ConnectionStatus.online) {
      String fullUrl = _ip + url;
      http.Response res = await http.get(
        fullUrl,
        headers: _setHeader(),
      );
      return res;
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) => onConnectionFailed());
    }
  }

  _setHeader() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
