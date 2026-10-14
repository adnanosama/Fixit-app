import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static bool _isFirebaseInitialized = false;

  /// Initialize Firebase safely with error handling for environments missing configuration
  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      _isFirebaseInitialized = true;
    } catch (e) {
      debugPrint("Firebase Core note: $e");
      _isFirebaseInitialized = false;
    }
  }

  /// Get current user email if signed in
  static String? get currentUserEmail {
    if (_isFirebaseInitialized && _auth.currentUser != null) {
      return _auth.currentUser!.email;
    }
    return _localUserEmail;
  }

  static String? _localUserEmail = "consumer@fixitpro.com";

  static bool get isLoggedIn => currentUserEmail != null;

  /// Sign in with email and password
  static Future<String?> signIn(String email, String password) async {
    if (_isFirebaseInitialized) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        return null; // Success
      } on FirebaseAuthException catch (e) {
        return e.message ?? "Authentication failed";
      } catch (e) {
        return e.toString();
      }
    } else {
      // Local session fallback
      _localUserEmail = email;
      return null;
    }
  }

  /// Sign up / Register new account
  static Future<String?> signUp(String email, String password) async {
    if (_isFirebaseInitialized) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return null; // Success
      } on FirebaseAuthException catch (e) {
        return e.message ?? "Sign up failed";
      } catch (e) {
        return e.toString();
      }
    } else {
      _localUserEmail = email;
      return null;
    }
  }

  /// Sign out current user
  static Future<void> signOut() async {
    if (_isFirebaseInitialized) {
      await _auth.signOut();
    }
    _localUserEmail = null;
  }
}
