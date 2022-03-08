//import 'dart:html';
import 'dart:io' as i;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_cupertino_date_textbox/custom_cupertino_date_textbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:petba/constants.dart';
import 'package:petba/screens/appbar.dart';
import 'package:petba/screens/padding.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';

class AdoptionUploadScreen extends StatefulWidget {
  static const id = "adoption_upload_screen";
  @override
  _AdoptionUploadScreenState createState() => _AdoptionUploadScreenState();
}

class _AdoptionUploadScreenState extends State<AdoptionUploadScreen> {
  double statusBarHeight, windowHeight, windowWidth;
  String dropdownValue = 'Dog';

  i.File imageFile;
  final picker = ImagePicker();
  var colector = 0;


  // chooseImage(ImageSource source) async{
  //   final pickerFile = await picker.getImage(source: source);
  //
  //   setState(() {
  //     imageFile = i.File(pickerFile.path);
  //   });
  // }
/////////////////////////////////////////
  List<Asset> images = List<Asset>();
  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: resultList,
        // materialOptions: MaterialOptions(
        //   actionBarTitle: "FlutterCorner.com",
        // ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
      colector = 1;
      print(images);
    });
  }
 ///////////////////////////////////////////



  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    windowHeight = MediaQuery.of(context).size.height - statusBarHeight;
    windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
       title: Text('Add For Adoption'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          height: windowHeight - 55,
          child: Column(
            children: [

              Pad(),
              Container(
                width: windowWidth * 0.94,
                child: Text(
                  'Upload Pictures',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kThemeColour,
                  ),
                ),
              ),
              Pad(),
              Container(
                width: windowWidth * 0.94,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //if or else if image is empty add secren  or image
                    InkWell(
                      child: colector != 0 ?
                      Container(
                        height: 110,
                        width: windowWidth * 0.94,
                          child: GridView.count(
                              crossAxisSpacing: 4.0,
                              crossAxisCount: 4,
                        children: List.generate(images.length, (index) {
                          Asset asset = images[index];
                          print (images[index]);

                          return AssetThumb(
                              asset: asset,
                              width: 50,
                              height: 100
                          );
                        })
                      )
                      )

                          : // or
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            pickImages();
                          },
                          child: Icon(
                              FontAwesomeIcons.plus,
                          ),
                        ),
                      ),
//////////////////////////////////////
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 3,
//                   children: List.generate(images.length, (index) {
//                     Asset asset = images[index];
//                     return AssetThumb(
//                       asset: asset,
//                       width: 300,
//                       height: 300,
//                     );
//                   }),
//                 ),
                    /////////////////////////////////////
                    //     Container(
                    //       width: 80,
                    //       height: 100,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10),
                    //           image: DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: FileImage(imageFile ,),
                    //           )
                    //       ),
                    //     )
//////////////////////////////////////
                    ),
                  ],
                ),
              ),
              Pad(),
              Container(
                width: windowWidth * 0.94,
                child: Text(
                  'Pet Details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kThemeColour,
                  ),
                ),
              ),
              Container(
                width: windowWidth * 0.94,
                child: TextField(
                  onChanged: (value) {
                    //
                  },
                  decoration: InputDecoration(
                    labelText: 'Pet Name',
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                ),
              ),
              Pad(),
              Container(
                width: windowWidth * 0.94,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.95),
                    width: 1.0,
                  ),
                )),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(FontAwesomeIcons.sortDown),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey.shade700),
                  isExpanded: true,
                  underline: Container(height: 0.0),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items:
                      <String>['Dog', 'Cat', 'Bird', 'Other'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Pad(),
              Container(
                width: windowWidth * 0.94,
                child: TextField(
                  onChanged: (value) {
                    //
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                ),
              ),
              Pad(),
              Container(
                width: windowWidth * 0.94,
                child: CustomizableCupertinoDateTextBox(
                  initialValue: DateTime.now(),
                  hintText: "Choose Date",
                ),
              ),
              Pad(),
              Container(
                decoration:
                    BoxDecoration(color: kThemeColour, borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 45,
                width: windowWidth * 0.93,
                child: InkWell(
                  child: Center(
                    child: Text(
                      "Add Pet",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    //
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
