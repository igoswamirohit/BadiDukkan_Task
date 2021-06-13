import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/screens/authentication/otp_page.dart';

class AuthenticationRepository {
  AuthenticationRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  BehaviorSubject<String> code = BehaviorSubject.seeded('');

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  void signInUsingPhone(BuildContext context, String phone){
    _firebaseAuth.verifyPhoneNumber
      (phoneNumber: phone, verificationCompleted: (phoneAuthCredential) {
      print('Ver Suceess');
      print(phoneAuthCredential);
    }, verificationFailed: (error) {
        print('error');
        print(error);
    }, codeSent: (verificationId, forceResendingToken) async {
        print('Code Sent!');
        code.add(verificationId);
        Loader.hide();
        await Navigator.of(context).pushNamed(OtpPage.routeName);
    }, codeAutoRetrievalTimeout: (verificationId) {
        print('timeout');
        code.add(verificationId);
    },
    );
  }

  Future<PhoneAuthCredential> validateOtp(String smsCode) async {
    return PhoneAuthProvider
        .credential(verificationId: code.value, smsCode: smsCode);
  }
  }
