import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartOrderSuccessScreen extends StatefulWidget {
  static const id = 'cart_order_success_screen';
  @override
  _CartOrderSuccessScreenState createState() => _CartOrderSuccessScreenState();
}

class _CartOrderSuccessScreenState extends State<CartOrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    // bool args = true;
    return Scaffold(
      body: SafeArea(
        child: args ? Lottie.asset('animations/order_success.json') : Lottie.asset('animations/failed.json'),
      ),
    );
  }
}
