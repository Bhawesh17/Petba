import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:petba/model/places.dart';
import 'package:petba/providers/grooming/GroomingSearchProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

class GroomingSearchPage extends StatefulWidget {
  static const id = 'grooming_search_screen';
  @override
  _GroomingSearchPage createState() => _GroomingSearchPage();
}

class _GroomingSearchPage extends State<GroomingSearchPage> {
  double statusBarHeight, windowHeight, windowWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //To call after the Widget gets built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GroomingSearchProvider>(context, listen: false).fetchGroomingData();
    });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final groomer = Provider.of<GroomingSearchProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Groomers', width: 160),
            groomer.isLoading
                ? _LoadingGroomers(windowHeight: windowHeight)
                : Container(
                    height: windowHeight - 55,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < groomer.groomerData.length; i++)
                            (_GroomingContainer(
                              result: groomer.groomerData[i],
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

// ignore: must_be_immutable
class _GroomingContainer extends StatelessWidget {
  double windowWidth;
  _GroomingContainer({this.result});
  final Places result;

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    return Container(
      width: windowWidth * 0.94,
      margin: EdgeInsets.symmetric(vertical: windowWidth * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kThemeColour.withOpacity(0.10),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              height: 200,
              width: windowWidth,
              image: NetworkImage(result.photo),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: windowWidth * 0.68,
                child: Text(
                  result.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: windowWidth * 0.20,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    result.address,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: windowWidth * 0.90,
            alignment: Alignment.centerLeft,
            child: Text(
              result.timings,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffababab).withOpacity(0.80),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Container(
                  width: windowWidth * 0.44,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: result.phone == ' '
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffababab).withOpacity(0.80),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: kThemeColour),
                          color: Colors.white,
                        ),
                  child: Center(
                    child: result.phone == ' '
                        ? Text(
                            'Phone N/A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          )
                        : Text(
                            'Call now',
                            style: TextStyle(
                              color: kThemeColour,
                              fontSize: 14.0,
                            ),
                          ),
                  ),
                ),
                onTap: () async {
                  String url = 'tel:${result.phone}';
                  result.phone == ' '
                      ? print('No Phone')
                      : await canLaunch(url)
                          ? await launch(url)
                          : print('Could not launch $url');
                },
              ),
              InkWell(
                child: Container(
                  width: windowWidth * 0.44,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: kThemeColour),
                    borderRadius: BorderRadius.circular(10.0),
                    color: kThemeColour,
                  ),
                  child: Center(
                    child: Text(
                      'Get Directions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // MapsLauncher.launchCoordinates(result.lat, result.lng);
                  MapsLauncher.launchQuery('${result.name}, ${result.formattedAddress}');
                },
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

class _LoadingGroomers extends StatelessWidget {
  _LoadingGroomers({this.windowHeight});
  final double windowHeight;

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: kShimmerBgColor,
      highlightColor: kShimmerColor,
      child: Container(
        height: windowHeight - 55,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.0),
              for (int i = 0; i < 5; i++)
                (Container(
                  height: 250.0,
                  width: windowWidth * 0.94,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
