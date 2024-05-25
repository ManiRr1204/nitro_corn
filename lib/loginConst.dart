import 'package:google_sign_in/google_sign_in.dart';

String? authType;

late Function() signout;
late GoogleSignInAccount? googleUser;

String? userName;
String? photoUrl;
String? userId;

String googleUserAuth = "googleUsers";