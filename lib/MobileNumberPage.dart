import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'HomePage.dart';
import 'ProfileSelectionPage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MoNoPage extends StatefulWidget {
  const MoNoPage({Key key}) : super(key: key);

  @override
  _MoNoPageState createState() => _MoNoPageState();
}

class _MoNoPageState extends State<MoNoPage> {
  final formKey = GlobalKey<FormState>();
  final formKeyOTP = GlobalKey<FormState>();
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  var codeSent = false;
  var isNumberScreen = true;
  var isOTPScreen = false;
  String verificationCode = '';
  String smsCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : returnNumberScreen();
  }

  Widget returnNumberScreen() {
    return Scaffold(
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
                              key: formKey,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                controller: numberController,
                                decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Montserrat',
                                        color: Colors.grey[800])),
                                validator: (number) {
                                  if (numberController.text.length < 10) {
                                    return 'Input a 10-digit mobile number.';
                                  }
                                  return null;
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
                        if (formKey.currentState.validate()) {
                          setState(() {
                            signUp();
                            isNumberScreen = false;
                            isOTPScreen = true;
                          });
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

  Widget returnOTPScreen() {
    return Scaffold(
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
                          setState(() {
                            isOTPScreen = false;
                            isNumberScreen = true;
                          });
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
                      codeSent
                          ? 'Please enter the OTP sent to ' +
                              numberController.text
                          : 'Sending OTP code SMS to ' + numberController.text,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.black),
                    ),
                    SizedBox(height: 30.0),
                    codeSent
                        ? Form(
                            key: formKeyOTP,
                            child: PinEntryTextField(
                              onSubmit: (String pin) {
                                if (pin.length < 6) {
                                  return 'Please enter a valid OTP.';
                                } else
                                  smsCode = pin;
                              },
                              fields: 6,
                              fontSize: 20.0,
                              fieldWidth: 48.0,
                              showFieldAsBox: true,
                            ),
                          )
                        : Container(),
                    SizedBox(height: 30.0),
                    codeSent
                        ? Column(
                            children: [
                              Text(
                                'Did not receive code?',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                    color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      codeSent = false;
                                    });
                                    await signUp();
                                  },
                                  child: Text(
                                    'Resend code.',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ))
                            ],
                          )
                        : Container(),
                    codeSent
                        ? TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.indigo[900],
                                minimumSize: Size(300.0, 50.0),
                                primary: Colors.white),
                            onPressed: () async {
                              if (smsCode != null) {
                                try {
                                  await auth.signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationCode,
                                          smsCode: smsCode.toString()));
                                  setState(() {
                                    isOTPScreen = false;
                                    isNumberScreen = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProfilePage()),
                                      (route) => false);
                                } catch (e) {}
                              }
                            },
                            child: Text(
                              'VERIFY AND CONTINUE',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ))
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 1.0),
              SizedBox(height: 1.0)
            ])));
  }

  Future signUp() async {
    var phoneNumber = '+91' + numberController.text.toString();
    var verifyPhone = auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        auth.signInWithCredential(phoneAuthCredential);
        setState(() {
          codeSent = true;
          isNumberScreen = false;
          isOTPScreen = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ProfilePage()),
            (route) => false);
      },
      verificationFailed: (FirebaseAuthException authException) {
        print('${authException.message}');
      },
      codeSent: (verificationID, [forceResendToken]) {
        setState(() {
          verificationCode = verificationID;
          codeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (verificationID) {
        setState(() {
          verificationCode = verificationID;
        });
      },
      timeout: const Duration(seconds: 10),
    );
    await verifyPhone;
  }
}
