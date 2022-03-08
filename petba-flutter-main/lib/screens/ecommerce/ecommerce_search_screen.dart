import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:petba/constants.dart';
import 'package:petba/model/ecommerce.dart';
import 'package:petba/providers/ecommerce/EcommerceSearchProvider.dart';
import 'package:petba/screens/appbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'ecommerce_screen.dart';
import 'filter_screen.dart';

class EcommerceSearch extends StatefulWidget {
  static const String id = 'ecommerce_search_screen';
  @override
  _EcommerceSearchState createState() => _EcommerceSearchState();
}

class _EcommerceSearchState extends State<EcommerceSearch> {
  double windowHeight, windowWidth, statusBarHeight;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Provider.of<EcommerceSearchProvider>(context, listen: false).fetchProduct();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        print('Load More');
      }
    });
    super.initState();
  }

  void slideSort() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Price: Min - Max',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      print('Min - Max');
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Price: Max - Min',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Ascending: A - Z',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Descending: Z - A',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final petFood = Provider.of<EcommerceSearchProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget(title: 'Shop'),
              Container(
                height: windowHeight - 100,
                child: SingleChildScrollView(
                  child: petFood.isLoading
                      ? LoadingWidget(windowHeight: windowHeight)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(windowWidth * 0.03),
                                itemCount: petFood.productSearchData.length,
                                controller: _scrollController,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // childAspectRatio: 0.689,
                                  crossAxisSpacing: windowWidth * 0.03,
                                  mainAxisSpacing: windowWidth * 0.03,
                                ),
                                itemBuilder: (context, i) {
                                  return ProductBox(
                                    productData: petFood.productSearchData[i],
                                  );
                                }),
                          ],
                        ),
                ),
              ),
              Container(
                height: 45,
                color: kThemeColour,
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        child: Center(
                          child: Text(
                            'Sort',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onPressed: slideSort,
                      ),
                    ),
                    Container(
                      width: 0.5,
                      height: 45,
                      color: Color(0xffababab).withOpacity(0.5),
                    ),
                    Expanded(
                      child: FlatButton(
                        child: Center(
                          child: Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, FilterPage.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductBox extends StatelessWidget {
  ProductBox({this.productData});
  Ecommerce productData;
  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        width: windowWidth * 0.45,
        height: 350,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kThemeColour.withOpacity(0.10),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
              height: 222,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(productData.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: windowWidth * 0.25,
                    child: Text(
                      HtmlUnescape().convert(productData.name),
                      style: TextStyle(
                        fontSize: 12,
                        color: kThemeColour,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    "₹ ${productData.price}", //// data base data
                    style: TextStyle(
                      fontSize: 17,
                      color: kThemeColour,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productData.category,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffCFCFCF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${productData.weight} " + productData.weightClass,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffCFCFCF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, EcommerceScreen.id, arguments: productData.id);
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  LoadingWidget({@required this.windowHeight});
  final windowHeight;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBgColor,
      highlightColor: kShimmerColor,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.0333),
          for (int i = 0; i < 3; i++)
            (Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int j = 0; j < 2; j++)
                      (Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.45,
                        //margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                      ))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.0333),
              ],
            ))
        ],
      ),
    );
  }
}
