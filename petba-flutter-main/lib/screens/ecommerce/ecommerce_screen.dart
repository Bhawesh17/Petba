import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petba/constants.dart';
import 'package:petba/model/ecommerce.dart';
import 'package:petba/providers/ecommerce/EcommerceProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:shimmer/shimmer.dart';
import '../appbar.dart';

class EcommerceScreen extends StatefulWidget {
  static const id = 'ecommerce_screen';
  @override
  _EcommerceScreenState createState() => _EcommerceScreenState();
}

class _EcommerceScreenState extends State<EcommerceScreen> {
  double windowHeight, windowWidth, statusBarHeight;
  int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callData();
  }

  callData() async {
    final product = Provider.of<EcommerceProvider>(context, listen: false);
    product.isLoading = true;
    await id;
    product.fetchProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;

    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final product = Provider.of<EcommerceProvider>(context);

    var htmlUnescape = HtmlUnescape();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: 'Shop'),
            Container(
              height: windowHeight - 55,
              child: SingleChildScrollView(
                child: product.isLoading
                    ? LoadingWidget()
                    : Column(
                        children: [
                          SizedBox(height: 10.0),
                          SizedBox(
                            height: 200.0,
                            width: windowWidth,
                            child: Carousel(
                              images: [
                                for (int i = 0;
                                    i < product.productData.images.length;
                                    i++)
                                  (NetworkImage(product.productData.images[i])),
                              ],
                              dotSize: 0.0,
                              dotBgColor: Colors.white.withOpacity(0.0),
                              boxFit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: windowWidth * 0.93,
                            child: Text(
                              '${product.productData.price} ₹',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: windowWidth * 0.93,
                            child: Text(
                              htmlUnescape.convert(product.productData.name),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: windowWidth * 0.93,
                            child: Text(
                              product.productData.category,
                              textAlign: TextAlign.left, //// data base data
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          for (int i = 0; i < product.category.length; i++)
                            (CategoryWidget(
                              category: product.category[i],
                              option: (optionData, id) {
                                product.resetSelected(i, id);
                                product.optionData = optionData;
                              },
                            )),
                          SizedBox(height: 10.0),
                          Container(
                            height: 1,
                            width: windowWidth * 0.93,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: windowWidth * 0.93,
                            child: Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  (Star(active: product.rating[i])),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: windowWidth * 0.93,
                            child: Html(
                              data: htmlUnescape
                                  .convert(product.productData.description),
                              style: {
                                "span": Style(
                                  color: kThemeColour,
                                  fontSize: FontSize(14),
                                ),
                                "*": Style(
                                  margin: EdgeInsets.all(0),
                                ),
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                                color: kThemeColour,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 45,
                            width: windowWidth * 0.93,
                            child: InkWell(
                              child: Center(
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                product.addToCart(id, 1);
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          WishlistContainer(),
                          SizedBox(height: 10.0),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  CategoryWidget({this.category, this.option});
  final Category category;
  final Function(String optionData, int id) option;

  @override
  Widget build(BuildContext context) {
    //print(category.optionName.length);
    var data1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.title),
          SizedBox(height: 2.0),
          Row(
            children: [
              for (int i = 0; i < category.optionName.length; i++)
                (Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: category.isSelected[i]
                              ? Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                )
                              : Border.all(
                                  color: Color(0xffDCDCDC),
                                  width: 1.0,
                                ),
                          borderRadius: BorderRadius.all(Radius.circular(55))),
                      height: 51,
                      width: 51,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            category.optionName[i],
                            style: TextStyle(
                              fontSize: 14,
                              color: kThemeColour,
                            ),
                          ),
                        ),
                        onTap: () {
                          data1 =
                              '{"${category.optionId}":"${category.optionValueId[i]}"}';
                          option(data1, i);
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                  ],
                )),
            ],
          ),
        ],
      ),
    );
  }
}

class WishlistContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<EcommerceProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: kThemeColour,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            product.productData.wishlist
                ? Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 20,
                    color: Color(0xffFEA593),
                  )
                : Icon(
                    FontAwesomeIcons.heart,
                    size: 20,
                    color: kThemeColour.withOpacity(0.80),
                  ),
            SizedBox(
              width: 10,
            ),
            Text("Add to wishlist")
          ],
        ),
        onTap: () {
          Provider.of<EcommerceProvider>(context, listen: false)
              .toggleWishlist(product.productData.id);
        },
      ),
    );
  }
}

class Star extends StatelessWidget {
  final double active;
  Star({this.active = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: active == 1
          ? Icon(FontAwesomeIcons.solidStar, color: Colors.yellow)
          : active == 0.5
              ? Icon(FontAwesomeIcons.starHalfAlt, color: Colors.yellow)
              : Icon(FontAwesomeIcons.star, color: Colors.yellow),
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
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              width: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 20.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                for (int i = 0; i < 3; i++)
                  (Container(
                    height: 40.0,
                    width: 40.0,
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ))
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 30.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
