import 'package:flutter/material.dart';
import 'package:petba/constants.dart';
import 'package:petba/providers/user/UserDetailsProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/padding.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserDetails extends StatefulWidget {
  static const id = 'user_details';

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  double windowHeight, windowWidth, statusBarHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDetailsProvider>(context, listen: false).fetchUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<UserDetailsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarWidget(title: 'My Account', width: 180),
                Column(
                  children: [
                    Container(
                      height: windowHeight - 55,
                      child: SingleChildScrollView(
                        child: user.isLoading
                            ? LoadingWidget():
                         Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0),
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        height: 200,
                                        width: 200,
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Pad(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InputWidget(
                                              controller: user.firstName,
                                              label: "First Name",
                                              width: windowWidth * 0.42,
                                            ),
                                            InputWidget(
                                              controller: user.lastName,
                                              label: "Last Name",
                                              width: windowWidth * 0.42,
                                            ),
                                          ],
                                        ),
                                        Pad(),
                                        Center(
                                          child: Container(
                                            decoration: user.isLoadingButton
                                                ? BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                : BoxDecoration(
                                                    color: kThemeColour,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                            height: 40.0,
                                            width: 120.0,
                                            child: InkWell(
                                              child: Center(
                                                child: Text(
                                                  'Update',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                user.isLoadingButton ? print('') : user.pushUserDetails();
                                              },
                                            ),
                                          ),
                                        ),
                                        Pad(),
                                        Text(
                                          'Email Address',
                                          style: TextStyle(fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          user.email,
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        Pad(),
                                        Text(
                                          'Phone Numbers',
                                          style: TextStyle(fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          user.phone,
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        Pad(),
                                        Pad(),
                                        Pad(),
                                      ],
                                    ),
                                  ),
                                  Div(),
                                  ButtonWidget(title: 'Change Email'),
                                  Div(),
                                  ButtonWidget(title: 'Change Password'),
                                  Div(),
                                  ButtonWidget(title: 'Delete Account'),
                                  Div(),
                                ],
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Div extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
          color: kThemeColour,
        ),
      ),
      onPressed: () {
        //
      },
    );
  }
}

class InputWidget extends StatelessWidget {
  InputWidget({
    @required this.controller,
    @required this.label,
    @required this.width,
  });

  final TextEditingController controller;
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextField(
        style: TextStyle(color: kThemeColour, fontSize: 14.0),
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
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
            Center(
              child: Container(
                height: 250.0,
                width: 250.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
            Center(
              child: Container(
                height: 40.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
            Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Pad(),
          ],
        ),
      ),
    );
  }
}
