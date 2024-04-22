import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/core/firebase/firebase_provider.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/phone-verify/phone_verify_otp_page.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  AuthDataSource(this._firebaseAuth, this._fireStore);

// Apple Sign In
  Future<Either<User, String>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithProvider(appleProvider);

      await _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': '',
        'avatar': Avatar.getRandomAvatar().value
      }, SetOptions(merge: true));

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Google Sign In
  Future<Either<User, String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return right('User Cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': userCredential.user!.displayName,
        'avatar': Avatar.getRandomAvatar().value
      }, SetOptions(merge: true));

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Phone Number Sign In
  Future<Either<Unit, String>> sendOtp(
      BuildContext context, PhoneNumber phoneNumber) async {
    try {
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
          context.push(PhoneVerifyOtpPage.routeName,
              extra: PhoneVerifyArgument(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      return left(unit);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

  Future<Either<User, String>> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': '',
        'avatar': Avatar.getRandomAvatar().value
      }, SetOptions(merge: true));

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

  Future<Either<Unit, String>> resendOtp(PhoneNumber phoneNumber) async {
    try {
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
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      return left(unit);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(
      ref.read(firebaseAuthProvider), ref.read(firebaseFirestoreProvider)),
);
