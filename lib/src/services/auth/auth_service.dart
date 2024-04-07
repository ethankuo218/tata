import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/phone-verify/phone_verify_otp_page.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Apple Sign In
  Future<void> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    late UserCredential userCredential;

    if (kIsWeb) {
      userCredential =
          await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }

    _fireStore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'name': userCredential.user!.displayName,
      'avatar': Avatar.getRandomAvatar()
    }, SetOptions(merge: true));
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // create a new credential fro user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // finally sign in
    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    _fireStore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'name': userCredential.user!.displayName,
    }, SetOptions(merge: true));
  }

  // Phone Number Sign In
  Future<void> sendOtp(BuildContext context, PhoneNumber phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${phoneNumber.countryCode}${phoneNumber.nsn}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        switch (e.code) {
          case 'invalid-phone-number':
            print('The provided phone number is not valid.');
            break;
          default:
            print('An error occurred while verifying the phone number.');
            break;
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, PhoneVerifyOtpPage.routeName,
            arguments: PhoneVerifyArgument(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    _fireStore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'name': userCredential.user!.displayName,
    }, SetOptions(merge: true));
  }

  Future<void> resendOtp(PhoneNumber phoneNumber) {
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${phoneNumber.countryCode}${phoneNumber.nsn}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        switch (e.code) {
          case 'invalid-phone-number':
            print('The provided phone number is not valid.');
            break;
          default:
            print('An error occurred while verifying the phone number.');
            break;
        }
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
