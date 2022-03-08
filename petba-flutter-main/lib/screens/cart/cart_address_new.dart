import 'package:flutter/material.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/padding.dart';
import 'package:provider/provider.dart';
import 'package:petba/providers/cart/CartAddressNewProvider.dart';
import '../../constants.dart';

//this is basically where you can add more addresses
class CartAddressNew extends StatefulWidget {
  static const id = 'cart_address_new';
  @override
  _CartAddressNewState createState() => _CartAddressNewState();
}

class _CartAddressNewState extends State<CartAddressNew> {
  double statusBarHeight, windowHeight, windowWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<CartAddressNewProvider>(context, listen: false).fetchZone();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final userDetails = Provider.of<CartAddressNewProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(title: 'Cart'),
              userDetails.isLoading
                  ? Container()
                  : Container(
                      width: windowWidth * 0.94,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Pad(),
                            TittleBar(name: "Contact Details"),
                            Pad(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: InputField(
                                    name: 'First Name',
                                    controller: userDetails.firstNameController,
                                  ),
                                  width: windowWidth * 0.45,
                                ),
                                Container(
                                  child: InputField(
                                    name: 'Last Name',
                                    controller: userDetails.lastNameController,
                                  ),
                                  width: windowWidth * 0.45,
                                ),
                              ],
                            ),
                            Pad(),
                            InputField(
                              name: 'Phone',
                              numberPad: true,
                              controller: userDetails.phoneController,
                            ),
                            Pad(),
                            Pad(),
                            TittleBar(name: "Address Details"),
                            Pad(),
                            InputField(
                              name: 'Pincode',
                              numberPad: true,
                              controller: userDetails.pincodeController,
                            ),
                            Pad(),
                            InputField(
                              name: 'Address (House no., Building, Area)',
                              controller: userDetails.addressController,
                            ),
                            Pad(),
                            InputField(
                              name: 'Locality/Town',
                              next: false,
                              controller: userDetails.cityController,
                            ),
                            Pad(),
                            Container(
                              height: 40,
                              width: windowWidth * 0.94,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey.withOpacity(0.10)),
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      buttonTheme: ButtonTheme.of(context)
                                          .copyWith(alignedDropdown: true)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      iconEnabledColor: kThemeColour,
                                      items:
                                          userDetails.zone.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: kThemeColour,
                                                fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          userDetails.zoneValue =
                                              value; // saving the selected value
                                        });
                                      },
                                      value: userDetails
                                          .zoneValue, // displaying the selected value
                                    ),
                                  )),
                            ),
                            Pad(),
                            Pad(),
                            InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: userDetails.buttonSelected
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        color: Colors.grey.withOpacity(0.50),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        color: kThemeColour,
                                      ),
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (!userDetails.buttonSelected) {
                                  userDetails.addAddress();
                                }
                              },
                            ),
                            SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TittleBar extends StatelessWidget {
  TittleBar({this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 18,
        color: kThemeColour,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class InputField extends StatelessWidget {
  InputField(
      {@required this.name,
      this.numberPad = false,
      this.next = true,
      this.controller});
  final String name;
  final bool numberPad, next;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        style: TextStyle(color: kThemeColour),
        keyboardType: numberPad ? TextInputType.number : TextInputType.name,
        textInputAction: next ? TextInputAction.next : TextInputAction.done,
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        ),
      ),
    );
  }
}
