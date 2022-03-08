import 'package:flutter/material.dart';
import 'package:petba/constants.dart';
import 'package:petba/screens/padding.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../appbar.dart';

class PlacedOrderDetails extends StatefulWidget {
  static const id = "placed_order_details";
  @override
  _PlacedOrderDetailsState createState() => _PlacedOrderDetailsState();
}

class _PlacedOrderDetailsState extends State<PlacedOrderDetails> {
  double statusBarHeight, windowHeight, windowWidth;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Track Order', width: 150),
            Container(
              height: windowHeight - 55,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Pad(),
                    Container(
                      width: windowWidth * 0.94,
                      child: Text(
                        "Wed,Sep 2021",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xffABABAB),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Pad(),
                    Container(
                      width: windowWidth * 0.94,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Oder ID: mnbgerfgh456",
                            style: TextStyle(
                              fontSize: 12,
                              color: kThemeColour,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "₹500",
                            style: TextStyle(
                              fontSize: 20,
                              color: kThemeColour,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pad(),
                    Container(
                      height: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            child: Container(
                              height: 130,
                              width: 100,
                              child: Image(
                                image: NetworkImage(
                                    'https://miro.medium.com/max/10368/1*o8tTGo3vsocTKnCUyz0wHA.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          Container(
                            width: windowWidth - 150,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Webox",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: kThemeColour,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "₹500",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: kThemeColour,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Pad(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pet Food",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffABABAB),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "1.5kg",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffABABAB),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Pad(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "1 Qty",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffABABAB),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Pad(),
                    Container(
                      width: windowWidth * 0.94,
                      child: Text(
                        'ETA: 2 days',
                        style: TextStyle(
                          fontSize: 20,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: windowWidth * 0.94,
                      child: Column(
                        children: [
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.0,
                            isFirst: true,
                            indicatorStyle: IndicatorStyle(color: Colors.red),
                            endChild: Text('\n Ready to Pickup\n'),
                            afterLineStyle: LineStyle(
                              color: Colors.red,
                              thickness: 2.0,
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.0,
                            beforeLineStyle: LineStyle(
                              color: Colors.red,
                              thickness: 2.0,
                            ),
                            indicatorStyle: IndicatorStyle(color: Colors.red),
                            endChild: Text('\n Order Picked Up\n'),
                            afterLineStyle: LineStyle(
                              color: Colors.red,
                              thickness: 2.0,
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.0,
                            isLast: true,
                            beforeLineStyle: LineStyle(
                              color: Colors.grey,
                              thickness: 2.0,
                            ),
                            indicatorStyle: IndicatorStyle(
                              color: Colors.grey,
                            ),
                            endChild: Text('\n Order Placed\n'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: windowWidth * 0.94,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 22,
                              child: Icon(
                                Icons.home_outlined,
                                color: kThemeColour,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 60,
                              width: windowWidth * 0.94 - 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kThemeColour,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kThemeColour,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'FF2 aquem alto margao goa',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: kThemeColour,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: windowWidth * 0.94,
                      height: 48,
                      decoration: BoxDecoration(
                        color: kThemeColour,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel Order',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
