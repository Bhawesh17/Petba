import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/constants.dart';
import 'package:provider/provider.dart';
import 'package:petba/providers/user/RegistrationProvider.dart';

class SignUpPage extends StatelessWidget {
  static const String id = 'signup_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SignUpPageData(),
    );
  }
}

class SignUpPageData extends StatefulWidget {
  @override
  _SignUpPageDataState createState() => _SignUpPageDataState();
}

class _SignUpPageDataState extends State<SignUpPageData> {
  double windowHeight;

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    final registrationProvider = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: windowHeight - 40,
            child: Column(
              children: [
                Expanded(child: Text('')),
                Padding(
                  padding: const EdgeInsets.only(right: 0, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New\nHere?',
                            style: TextStyle(
                              fontSize: 45,
                              color: Color(0xff253150),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Don't worry we got you",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffABABAB),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Container(
                        //height: 250,
                        width: 200,
                        child: Image(
                          image: AssetImage('images/Img1.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputField(
                    controller: registrationProvider.nameController,
                    placeholder: "Full name",
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputField(
                    controller: registrationProvider.emailController,
                    placeholder: "Email",
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputField(
                    controller: registrationProvider.passwordController,
                    placeholder: "Password",
                    obscure: true,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputField(
                    controller: registrationProvider.phoneController,
                    placeholder: "Phone number",
                    next: false,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Next  > ',
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
                        color: kThemeColour,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        elevation: 3.0,
                        child: MaterialButton(
                          onPressed: () {
                            registrationProvider.registerCheckData(context);
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
                ),
                Expanded(child: Text(''), flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: kThemeColour,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: kThemeColour,
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
  final bool obscure, next;
  InputField({
    this.controller,
    this.placeholder,
    this.obscure = false,
    this.next = true,
  });
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
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      ),
    );
  }
}
