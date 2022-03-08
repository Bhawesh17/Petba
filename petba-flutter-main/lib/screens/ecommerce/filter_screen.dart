import 'package:flutter/material.dart';
import 'package:petba/model/filter.dart';
import 'package:petba/model/filter_group.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import '../appbar.dart';
import 'package:petba/providers/ecommerce/FilterProvider.dart';

class FilterPage extends StatefulWidget {
  static const id = 'filter_screen';
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double statusBarHeight, windowHeight, windowWidth;
  bool _isChecked = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<FilterProvider>(context, listen: false).fetchFilterGroup();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    final filter = Provider.of<FilterProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(title: "Filter"),
            Container(
              //width: windowHeight - 55,
              child: filter.isLoadingGroup
                  ? LoadingWidget()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: windowHeight - 100,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < filter.filterGroupData.length;
                                    i++)
                                  (FilterList(
                                      filterGroupData:
                                          filter.filterGroupData[i]))
                              ],
                            ),
                          ),
                        ),
                        filter.isLoadingFilter
                            ? Container(
                                width: 200,
                                height: 400,
                                color: Colors.white,
                              )
                            : Container(
                                height: windowHeight - 100,
                                width: windowWidth - 100,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < filter.filterData.length;
                                          i++)
                                        (CheckBoxWidget(
                                            filterData: filter.filterData[i]))
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: windowWidth * 0.40,
                    child: Text(
                      '20 products',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: windowWidth * 0.40,
                      decoration: BoxDecoration(
                        color: kThemeColour,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print(filter.filterGroupData.length);
                      print(filter.isLoadingGroup);
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
class FilterList extends StatelessWidget {
  FilterList({@required this.filterGroupData, this.active = false});
  bool active;
  FilterGroupData filterGroupData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 100.0,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        decoration: filterGroupData.selected
            ? BoxDecoration()
            : BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
              ),
        child: Text(
          filterGroupData.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onTap: () {
        Provider.of<FilterProvider>(context, listen: false)
            .fetchFilter(filterGroupData.groupId);
      },
    );
  }
}

// ignore: must_be_immutable
class CheckBoxWidget extends StatelessWidget {
  CheckBoxWidget({@required this.filterData});
  FilterData filterData;
  bool _checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 200.0,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          filterData.name,
          style: TextStyle(color: kThemeColour),
        ),
        value: _checkboxValue,
        onChanged: (value) {
          //
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double windowHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: windowHeight - 130,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 350,
                        width: 100,
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < 10; i++)
                        (Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width - 180,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Colors.white,
                          ),
                        )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
