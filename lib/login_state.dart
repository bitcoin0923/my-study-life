/*
 * Copyright (c) 2021 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Utilities/constants.dart';
import 'main.dart';

class LoginState extends ChangeNotifier {
  final Ref ref;
  bool _loggedIn = false;

  LoginState(this.ref) {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    loggedIn = sharedPreferences.getBool(Constants.loggedInKey) ?? false;
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    sharedPreferences.setBool(Constants.loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    loggedIn = sharedPreferences.getBool(Constants.loggedInKey) ?? false;
  }
}


// class SettingsRepository {
//   const SettingsRepository(this.ref);
//   final Ref ref;

//   // synchronous read
//   bool onboardingComplete() {
//     final sharedPreferences = ref.read(sharedPreferencesProvider);
//     return sharedPreferences.getBool('onboardingComplete') ?? false;
//   }

//   // asynchronous write
//   Future<void> setOnboardingComplete(bool complete) {
//     final sharedPreferences = ref.read(sharedPreferencesProvider);
//     return sharedPreferences.setBool('onboardingComplete', complete);
//   }
// }

final loginStateProvider = Provider<LoginState>((ref) {
  return LoginState(ref);
});

