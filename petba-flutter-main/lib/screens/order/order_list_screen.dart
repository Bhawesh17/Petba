import 'package:flutter/material.dart';
import 'package:petba/constants.dart';
import 'package:petba/model/order.dart';
import 'package:petba/providers/order/OrderListProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/order/placed_order_details_screen.dart';
import 'package:petba/screens/padding.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderList extends StatefulWidget {
  static const id = 'order_list';
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  double statusBarHeight, windowHeight, windowWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderListProvider>(context, listen: false).fetchOrderList();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final order = Provider.of<OrderListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Order List', width: 160),
            Container(
              height: windowHeight - 55,
              child: SingleChildScrollView(
                child: order.isLoading
                    ? LoadingOrder()
                    : Column(
                        children: [
                          for (int i = 0; i < order.orderData.length; i++)
                            (ProductItem(
                              order: order.orderData[i],
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
class ProductItem extends StatelessWidget {
  ProductItem({this.order});
  OrderData order;

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Pad(),
          Container(
            height: 130,
            width: windowWidth * 0.94,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: kThemeColour.withOpacity(0.10),
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Container(
                    height: 130,
                    width: 100,
                    child: Image(
                      image: NetworkImage(imgBaseUrl + order.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 130,
                  width: windowWidth * 0.94 - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        order.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffABABAB),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Order ID: ${order.orderId}',
                        style: TextStyle(
                          fontSize: 14,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${order.quantity} Items',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffABABAB),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Price ₹${order.price}',
                          style: TextStyle(
                            fontSize: 20,
                            color: kThemeColour,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pad(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: windowWidth * 0.45,
                height: 40,
                decoration: BoxDecoration(
                  color: kThemeColour,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: kThemeColour.withOpacity(0.10),
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Cancel Order",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  width: windowWidth * 0.45,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: kThemeColour.withOpacity(0.10),
                        blurRadius: 6.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Track Order",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffFF5180),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, PlacedOrderDetails.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LoadingOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: MediaQuery.of(context).size.height - 55,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < 4; i++)
                (Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                ))
            ],
          ),
        ),
      ),
    );
  }
}
