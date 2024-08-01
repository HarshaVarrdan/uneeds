import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunc {
  final auth = FirebaseAuth.instance;

  Future<String> phoneAuthentication(
      String phoneNumber, Duration timeout) async {
    Completer<String> vID = Completer<String>();
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      codeSent: (verificationId, resendToken) async {
        vID.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      verificationFailed: (e) {
        vID.complete("");
      },
    );
    return vID.future;
  }

  Future<User?> phoneVerification(String otpVId, String otp) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: otpVId, smsCode: otp);
      // Sign the user in (or link) with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> googleAuthentication() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      return userCredential.user;
    }
    return null;
  }

  Future uploadFile(String parentFileName, String fileName, File photo) async {
    final destination = 'files/$parentFileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('$fileName');
      await ref.putFile(photo);
      print("File Uploaded");
    } catch (e) {
      print('error occured');
    }
  }
}
