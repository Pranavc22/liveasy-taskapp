import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_taskapp/VerifyPhonePage.dart';
import 'package:liveasy_taskapp/ProfileSelectionPage.dart';

class Auth {
  //Take you to Verification or Profile.
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return ProfilePage();
          else
            return VerifyPage();
        });
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }
}
