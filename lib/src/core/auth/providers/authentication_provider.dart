import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/core/firebase/firebase_provider.dart';

class AuthenticationNotifier extends ChangeNotifier {
  AuthenticationNotifier(this._firebaseAuth) {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        _isAuthenticated = true;
        notifyListeners();
      } else {
        _isAuthenticated = false;
        notifyListeners();
      }
    });
  }

  final FirebaseAuth _firebaseAuth;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
}

final authenticationProvider = ChangeNotifierProvider<AuthenticationNotifier>(
  (ref) => AuthenticationNotifier(ref.read(firebaseAuthProvider)),
);
