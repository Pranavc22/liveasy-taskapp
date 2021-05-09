import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liveasy_taskapp/HomePage.dart';
import 'package:liveasy_taskapp/VerifyPhonePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Auth.dart';

class MoNoPage extends StatefulWidget {
  const MoNoPage({Key key}) : super(key: key);

  @override
  _MoNoPageState createState() => _MoNoPageState();
}

class _MoNoPageState extends State<MoNoPage> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userID;
  String number;
  String smsCode = Data().smsCode;

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted veriSuccess = (AuthCredential authResult) {
      Auth().signIn(authResult);
    };
    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrieval = (String verID) {
      this.userID = verID;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + number,
        verificationCompleted: veriSuccess,
        verificationFailed: veriFailed,
        codeSent: (String verID, [int forceResend]) async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verID, smsCode: smsCode);
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: autoRetrieval,
        timeout: const Duration(seconds: 60));
  }

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
                                builder: (context) => HomePage()));
                      },
                      child:
                          Icon(Icons.close, color: Colors.black, size: 28.0))),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Please enter your mobile number.',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black)),
                  SizedBox(height: 20.0),
                  Text(
                    'You will receive a 6-digit code to verify next.',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: Colors.black),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 350.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0)),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            SvgPicture.asset('vectors/India.svg', width: 34.0),
                      ),
                      Text('+91   -   ',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Colors.black)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            width: 220.0,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                controller: _controller,
                                decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey[800])),
                                validator: (String number) {
                                  if (_controller.text.length < 10) {
                                    return 'Input a 10-digit mobile number.';
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  this.number = value;
                                },
                              ),
                            )),
                      )
                    ]),
                  ),
                  SizedBox(height: 30.0),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          minimumSize: Size(220.0, 50.0),
                          primary: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          verifyPhone();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => VerifyPage()));
                        }
                      },
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              SvgPicture.asset('vectors/Vector4.svg', width: 412.0),
              SvgPicture.asset('vectors/Vector3.svg', width: 412.0)
            ])
          ],
        ),
      ),
    );
  }
}
