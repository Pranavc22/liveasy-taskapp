import 'package:flutter/material.dart';
import 'package:liveasy_taskapp/MobileNumberPage.dart';
import 'ProfileSelectionPage.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class Data {
  String smsCode;
}

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => MoNoPage()));
                        },
                        child: Icon(Icons.arrow_back,
                            color: Colors.black, size: 28.0))),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Verify Phone',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.black)),
                    SizedBox(height: 20.0),
                    Text(
                      'Please enter the OTP sent to your number.',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30.0),
                    PinEntryTextField(
                      onSubmit: (String pin) {
                        Data().smsCode = pin;
                      },
                      fields: 6,
                      fontSize: 20.0,
                      fieldWidth: 48.0,
                      showFieldAsBox: true,
                    ),
                    SizedBox(height: 30.0),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.indigo[900],
                            minimumSize: Size(300.0, 50.0),
                            primary: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child: Text(
                          'VERIFY AND CONTINUE',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 1.0),
              SizedBox(height: 1.0)
            ])));
  }
}
