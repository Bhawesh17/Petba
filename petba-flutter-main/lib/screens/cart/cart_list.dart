import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/model/cart.dart';
import 'package:petba/model/screenArguments.dart';
import 'package:petba/providers/cart/CartProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/cart/cart_payment.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import 'cart_address.dart';

class CartList extends StatefulWidget {
  static const id = 'cart_list';

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  double statusBarHeight, windowHeight, windowWidth;
  @override
  void initState() {
    super.initState();

    //Provider.of<CartListProvider>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final cartData = Provider.of<CartListProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: "Cart"),
            //
            Container(
              height: windowHeight - 180,
              child: SingleChildScrollView(
                child: cartData.isLoading
                    ? LoadingWidget()
                    : Column(
                        children: [
                          SizedBox(height: windowWidth * 0.015),
                          for (int i = 0; i < cartData.cartProducts.length; i++)
                            (CartContainer(cart: cartData.cartProducts[i])),
                        ],
                      ),
              ),
            ),
            //
            Container(
              width: windowWidth * 0.94,
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax",
                        style: TextStyle(
                          fontSize: 14,
                          color: kThemeColour,
                        ),
                      ),
                      Text(
                        "₹ ${cartData.tax}.0", //// data base data
                        style: TextStyle(
                          fontSize: 14,
                          color: kThemeColour,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Charges",
                        style: TextStyle(
                          fontSize: 14,
                          color: kThemeColour,
                        ),
                      ),
                      Text(
                        "₹ ${cartData.deliveryCharges}", //// data base data
                        style: TextStyle(
                          fontSize: 14,
                          color: kThemeColour,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "₹ ${cartData.total}", //// data base data
                        style: TextStyle(
                          fontSize: 18,
                          color: kThemeColour,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: kThemeColour,
                      ),
                      child: Text(
                        "Order now",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CartPayment.id,
                        arguments: ScreenArguments(cartTotal: cartData.total),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CartContainer extends StatelessWidget {
  CartContainer({this.cart});
  Cart cart;
  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final cartData = Provider.of<CartListProvider>(context);
    return InkWell(
      child: Container(
        height: 130,
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                height: 130,
                width: 120,
                image: NetworkImage(imgBaseUrl + cart.image),
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: (windowWidth * 0.94) - 120,
              padding: const EdgeInsets.only(left: 9, right: 9, top: 0, bottom: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (windowWidth * 0.94) - 200,
                        child: Text(
                          cart.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: kThemeColour,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        '₹ ${cart.price}',
                        style: TextStyle(
                          fontSize: 16,
                          color: kThemeColour,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cart.category,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffCFCFCF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${cart.weight} " + cart.weightClass,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffCFCFCF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      cartData.isLoadingQuantity
                          ? LoadingQuantity()
                          : InkWell(
                              child: Container(
                                decoration: cart.quantity > 1
                                    ? BoxDecoration(
                                        color: kThemeColour,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      )
                                    : BoxDecoration(
                                        color: kThemeColour.withOpacity(0.10),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                height: 25,
                                width: 25,
                                child: Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              onTap: () {
                                if (cart.quantity > 1) {
                                  Provider.of<CartListProvider>(context, listen: false)
                                      .quantityUpdate(cart.productId, cart.quantity - 1);
                                }
                              },
                            ),
                      SizedBox(width: 5.0),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Color(0xffDCDCDC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${cart.quantity}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kThemeColour,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      cartData.isLoadingQuantity
                          ? LoadingQuantity()
                          : InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kThemeColour,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                height: 25,
                                width: 25,
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              onTap: () {
                                Provider.of<CartListProvider>(context, listen: false)
                                    .quantityUpdate(cart.productId, cart.quantity + 1);
                              },
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        //
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBgColor,
      highlightColor: kShimmerColor,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.0333),
          for (int i = 0; i < 4; i++)
            (Column(
              children: [
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width * 0.94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              ],
            ))
        ],
      ),
    );
  }
}

class LoadingQuantity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBgColor,
      highlightColor: kShimmerColor,
      child: Container(
        height: 25.0,
        width: 25.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
