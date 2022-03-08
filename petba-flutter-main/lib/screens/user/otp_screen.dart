import 'package:flutter/material.dart';
import 'package:petba/screens/dashboard_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  static const String id = 'OTPScreen';
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otp = TextEditingController();
  int phoneNumber = 919876543210;
  double timer = 0.26;
  double statusBarHeight, windowHeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: windowHeight - 120, //570.0
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't Worry",
                      style: TextStyle(
                        fontSize: 45,
                        color: Color(0xff253150),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Just sniffing to check if it's you",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffABABAB),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Container(
                    height: 244,
                    width: 253,
                    child: Image.asset(
                      'images/Img3.png',
                      width: 116,
                      height: 92,
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Container(
                    child: Text(
                      'Otp sent to $phoneNumber',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffABABAB),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Resend code in $timer",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff253150),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 45),

                  //Here is the code for the OTP input fields
                  Form(
                    child: Container(
                      width: 250,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.normal,
                        ),
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 58,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          selectedColor: Colors.grey,
                          activeColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          borderWidth: 1.0,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 25, height: 1.3),
                        enableActiveFill: true,
                        controller: otp,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          print("Completed");
                          print(otp.text);
                          Navigator.pushNamed(context, HomePage.id);
                          otp.clear();
                        },
                        onChanged: null,
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
