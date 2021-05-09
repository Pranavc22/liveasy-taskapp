import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'MobileNumberPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String valueChosen;
  List listItems = [
    'English',
    'Hindi',
    'Punjabi',
    'Malayalam',
    'Tamil',
    'Telugu'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 1.0),
            Column(
              children: [
                Icon(Icons.image_outlined, size: 100.0, color: Colors.black),
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    'Please select your language',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text('You can change the language at any time.',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0)),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: DropdownButton(
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36.0,
                    hint: Text('Select a Language'),
                    dropdownColor: Colors.blue[200],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Montserrat',
                        color: Colors.black),
                    value: valueChosen,
                    onChanged: (newValue) {
                      setState(() {
                        valueChosen = newValue;
                      });
                    },
                    items: listItems.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(220.0, 50.0),
                        primary: Colors.white,
                        backgroundColor: Colors.indigo[900]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => MoNoPage()));
                    },
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              SvgPicture.asset('vectors/Vector2.svg', width: 412.0),
              SvgPicture.asset('vectors/Vector1.svg', width: 412.0)
            ]),
          ],
        ),
      ),
    ));
  }
}
