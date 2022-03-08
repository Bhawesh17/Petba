import 'package:flutter/material.dart';
import 'package:petba/model/address.dart';
import 'package:petba/model/screenArguments.dart';
import 'package:petba/providers/cart/CartPaymentProvider.dart';
import 'package:petba/screens/cart/cart_payment.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cart_address_new.dart';
import 'package:petba/screens/appbar.dart';

class CartAddress extends StatefulWidget {
  static const id = 'cart_address';
  @override
  _CartAddressState createState() => _CartAddressState();
}

class _CartAddressState extends State<CartAddress> {
  double statusBarHeight, windowHeight, windowWidth;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartPaymentProvider>(context, listen: false).fetchAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final address = Provider.of<CartPaymentProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Cart'),
            Container(
              height: 40,
              width: windowWidth * 0.94,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CartAddressNew.id);
                },
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.red,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add address',
                      style: TextStyle(
                        fontSize: 16,
                        color: kThemeColour,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            Container(
              height: windowHeight - 96,
              child: SingleChildScrollView(
                child: address.isLoadingAddressList
                    ? Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      )
                    : Column(
                        children: [
                          for (int i = 0; i < address.addressList.length; i++)
                            (InkWell(
                              child: Addresses(address: address.addressList[i]),
                              onTap: () {
                                address.fetchActiveAddress(address.addressList[i].addressId);
                                Navigator.pop(context);
                              },
                            ))
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Addresses extends StatelessWidget {
  Addresses({this.address});
  final Address address;

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: kThemeColour,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 40.0,
            child: InkWell(
              child: Center(
                child: Text(
                  'Change or edit address',
                  style: TextStyle(
                    fontSize: 16,
                    color: kThemeColour,
                  ),
                ),
              ),
              onTap: () {
                //
              },
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
