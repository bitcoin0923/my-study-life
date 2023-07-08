import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AuthController extends ChangeNotifier {
  // mutable state
 // User? user;
  // computed state
  bool isSignedIn = false;

  Future<void> signOut() async {
    // update state
    isSignedIn = false;
    // and notify any listeners
    notifyListeners();
  }

  Future<void> signIn() async {
    // update state
    isSignedIn = true;
    // and notify any listeners
    notifyListeners();
  }




  
}

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});

