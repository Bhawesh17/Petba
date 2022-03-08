import 'package:flutter/material.dart';
import 'package:petba/model/screenArguments.dart';
import 'package:petba/providers/cart/CartPaymentProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/cart/cart_address.dart';
import 'package:petba/screens/padding.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import 'cart_order_success_screen.dart';
import 'package:petba/model/address.dart';

class CartPayment extends StatefulWidget {
  static const id = 'cart_payment';
  @override
  _CartPaymentState createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  Razorpay _razorpay;
  double statusBarHeight, windowHeight, windowWidth;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //fetchUserEmail();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(ScreenArguments args) async {
    final data = Provider.of<CartPaymentProvider>(context, listen: false).address;
    print(data.phone);
    var options = {
      'key': razorApiKey,
      'amount': args.cartTotal * 100, //since razorpay deals in paise
      'name': 'Petba',
      'description': 'Check Out',
      'image': 'https://uk.pedigree.com/asset/img/logo-home.png',
      'prefill': {
        'contact': data.phone,
        'email': 'aaron@test.com',
      },
      'readonly': {
        'email': true,
        'contact': true,
        'name': true,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: " + response.paymentId);
    final payment = Provider.of<CartPaymentProvider>(context, listen: false);
    //TODO: how to get the total
    // payment.pushToDb(args.cartTotal);
    Navigator.pushNamed(context, CartOrderSuccessScreen.id, arguments: true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final payment = Provider.of<CartPaymentProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              AppBarWidget(title: 'Cart'),
              Pad(),
              TittleWidget(title: 'Address'),
              Pad(),
              payment.isLoadingAddress ? LoadingAddress() : AddressWidget(address: payment.address),
              Pad(),
              TittleWidget(title: 'Payment Methods'),
              ListTile(
                title: const Text('Cash On Delivery'),
                leading: Radio(
                  value: 1,
                  groupValue: payment.radioButton,
                  onChanged: (a) {
                    setState(() {
                      payment.radioButton = 1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Pre-Paid'),
                leading: Radio(
                  value: 2,
                  groupValue: payment.radioButton,
                  onChanged: (a) {
                    setState(() {
                      payment.radioButton = 2;
                    });
                  },
                ),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: windowWidth * 0.94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kThemeColour,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () async {
                  if (payment.radioButton == 1) {
                    Future<bool> data = payment.pushToDb(args.cartTotal);
                    bool success;
                    if (await data) {
                      success = true;
                    } else {
                      success = false;
                    }
                    Navigator.pushNamed(context, CartOrderSuccessScreen.id, arguments: success);
                  } else if (payment.radioButton == 2) {
                    openCheckout(args);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TittleWidget extends StatelessWidget {
  TittleWidget({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    return Container(
      width: windowWidth * 0.94,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  AddressWidget({this.address});
  final Address address;
  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;
    return Container(
      width: windowWidth * 0.94,
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                address.firstName + ' ' + address.lastName,
                style: TextStyle(
                  fontSize: 18,
                  color: kThemeColour,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                address.type,
                style: TextStyle(
                  fontSize: 16,
                  color: kThemeColour,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              address.address + ', ' + address.city + ', ' + address.zone + ' - ' + address.country,
              style: TextStyle(
                fontSize: 14,
                color: kThemeColour,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                'Mobile: ',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffABABAB),
                ),
              ),
              Text(
                '${address.phone}',
                style: TextStyle(
                  fontSize: 14,
                  color: kThemeColour,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Text('Change Address  '),
              onTap: () {
                Navigator.pushNamed(context, CartAddress.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBgColor,
      highlightColor: kShimmerBgColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
