import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/constants.dart';
import 'package:petba/screens/user/otp_screen.dart';
import 'package:petba/screens/user/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:petba/providers/user/LoginProvider.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginPageData(),
    );
  }
}

class LoginPageData extends StatefulWidget {
  @override
  _LoginPageDataState createState() => _LoginPageDataState();
}

class _LoginPageDataState extends State<LoginPageData> {
  double windowHeight;
  double windowWidth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            height: windowHeight - 55.0,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Expanded(child: Text(''), flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                            fontSize: 50,
                            color: Color(0xff253150),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'Paw your details please',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffABABAB),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 140,
                      child: Image.asset('images/Img2.png'),
                    ),
                  ],
                ),
                Container(
                  child: InputField(
                    controller: loginProvider.loginEmailController,
                    placeholder: "Email address",
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: InputField(
                    controller: loginProvider.loginPasswordController,
                    placeholder: "Password",
                    obscure: true,
                    next: false,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, OtpPage.id);
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xff253150),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Sign in  > ',
                      style: TextStyle(
                        fontSize: 20,
                        color: kThemeColour,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Material(
                      color: Color(0xff253150),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      elevation: 3.0,
                      child: MaterialButton(
                        onPressed: () {
                          //logProvider.changeName();
                          loginProvider.loginCheckData(context);
                        },
                        minWidth: 65.0,
                        height: 65,
                        child: Icon(
                          FontAwesomeIcons.paw,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Text(''), flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Color(0xff253150),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xff253150),
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool obscure;
  final bool next;
  InputField(
      {this.controller,
      this.placeholder,
      this.obscure = false,
      this.next = true});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black, fontSize: 14.0),
      controller: controller,
      obscureText: obscure,
      textInputAction: next ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
    );
  }
}
