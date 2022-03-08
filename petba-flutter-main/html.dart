import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String stateValue = '-Select-';
  List<String> states = [
    '-Select-',
    'Goa',
    'Delhi',
    'Kerala',
    'Maharasthra',
    'sadfsd',
    'gbfdsajbfwa',
    'ireg',
    'etwe',
    'dgasd',
    'fdewt',
    'fsafa',
    'rtsfd',
    'awtsd',
    'fsagag',
    'regdvf',
    'dwsgsz',
    'gewafc'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 24, top: 12),
      child: Container(
        height: 55, //gives the height of the dropdown button
        width: 300, //gives the width of the dropdown button
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey),
        child: Theme(
            data: Theme.of(context).copyWith(
                buttonTheme:
                    ButtonTheme.of(context).copyWith(alignedDropdown: true)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconEnabledColor: Colors.red,
                items: states.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    stateValue = value; // saving the selected value
                  });
                },
                value: stateValue, // displaying the selected value
              ),
            )),
      ),
    );
  }
}
