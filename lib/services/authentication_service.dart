import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
//

import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/error_page.dart';

class AuthenticationService {
  checkIfTheUserIsAuthenticatedAndRedirectToPage() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          return (snapshot.hasData) ? HomePage() : LoginPage();
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  signIn(String email, String password, context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((val) {
      print('signed in');
    }).catchError((e) {
      ErrorPage().errorDialog(context, e);
    });
  }

  //Sign in with Facebook
  fbSignIn() async {
    final fb = FacebookLogin();

    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in
        // Send access token to server for validation and auth

        // FIXME final FacebookAccessToken accessToken = res.accessToken;
        // FIXME final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken.token);
        // FIXME final result = await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  //Signup a new user
  signUp(String email, String password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
