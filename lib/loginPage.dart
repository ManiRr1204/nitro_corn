import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nitro_corn/googleSignInState.dart';
import 'package:nitro_corn/instructionScreen.dart';
import 'package:nitro_corn/loginConst.dart';
import 'package:nitro_corn/loginScaffold.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'dart:io' show Platform;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// LogIn Button with auth icon Refer Link - https://pub.dev/packages/flutter_signin_button

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  GoogleSignInState googleSignInState = GoogleSignInState.failure;

  // String? ip;

  void handleGoogleSignInStateAndLog(GoogleSignInAccount currentUser) async {
    setState(() {
      googleSignInState = GoogleSignInState.init;
    });
    // userLogLevel =
    //     await loggerLevelService().getLogLevelForUser(currentUser.email);

    // loggerDataService = LoggerDataService(
    //     platform: platform,
    //     id: currentUser.email,
    //     logLevel: userLogLevel!.name);
    // await loggerDataService!.setDeviceInfo();
    setState(() {
      authType = googleUserAuth;
      userName = googleUser!.displayName;
      photoUrl = googleUser!.photoUrl;
      userId = googleUser!.email;
      googleSignInState = GoogleSignInState.success;
    });
  }

  void checkPreviouslySignedIn() async {
    _currentUser = await _googleSignIn.signInSilently();
    if (_currentUser != null) {
      handleGoogleSignInStateAndLog(_currentUser!);
      signout = googleSignOut;
      googleUser = _currentUser;
    }
    // Google signin failure
    else {
      setState(() {
        googleSignInState = GoogleSignInState.failure;
      });
    }
  }

  void getUserDetailsFromStorage() async {
    await SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('authType') &&
          prefs.containsKey('userName') &&
          prefs.containsKey('userId') &&
          prefs.containsKey('photoUrl')) {
        authType = prefs.getString('authType');
        userName = prefs.getString('userName');
        userId = prefs.getString('userId');
        photoUrl = prefs.getString('photoUrl');
        if (authType == googleUserAuth) {
          signout = googleSignOut;
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    getUserDetailsFromStorage();
    _googleSignIn.onCurrentUserChanged.listen((account) async {
      if (account != null && _currentUser == null) {
        setState(() {
          _currentUser = account;
          googleUser = _currentUser;
          authType = googleUserAuth;
          userName = googleUser!.displayName;
          photoUrl = googleUser!.photoUrl;
          userId = googleUser!.email;
          signout = googleSignOut;
        });
        handleGoogleSignInStateAndLog(account);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authType', authType!);
        await prefs.setString('userId', userId!);
        await prefs.setString('userName', userName!);
        await prefs.setString('photoUrl', photoUrl ?? "");
      }
    });
    super.initState();
    // () async {
    //   ip ??= await getIp();
    // }();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {

    if (googleSignInState == GoogleSignInState.init) {
      return const LoginScaffoldWidget(widget: Center(child: CircularProgressIndicator()));
    } else if ((userName != null && userId != null && photoUrl != null) ||
        googleSignInState == GoogleSignInState.success) {

      return LoginScaffoldWidget(widget: InstructionScreen());
    } else {
      return LoginScaffoldWidget(
        widget: Container(
          alignment: Alignment.center,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    'Sign in with',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SignInButton(
                      Buttons.google,
                      // mini: true,
                      text: "Sign up with Google",
                      onPressed: googleSignIn,
                      // buttonType: ButtonType.google,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.025,
                  ),
                  const Text(
                    "Powered By",
                    style: TextStyle(
                        fontSize: 20 / 1.2,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 17, 1, 12)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  const Text(
                    // " Arjava India Tech Pvt Ltd",
                    "Neural Ninjas",
                    style: TextStyle(
                        fontSize: 20 / 1.2,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 1, 12)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void googleSignOut() {
    _googleSignIn.disconnect();
  }

  Future<void> googleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in $e');
    }
  }
}
