import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/user.model.dart';
import '../Services/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

enum AuthStatus { loading, authenticated, unauthenticated, failed }

class AuthState extends Equatable {
  const AuthState._(
      {this.user = UserModel.empty, this.status = AuthStatus.loading});

  const AuthState.loading() : this._();

  const AuthState.authenticated(UserModel user)
      : this._(user: user, status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final UserModel user;
  final AuthStatus status;

  @override
  List<Object?> get props => [user, status];
}

class AuthNotifier extends StateNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();

  AuthNotifier(Ref ref)
      : repo = ref.read(appRepositoryProvider),
        super(AuthState.loading()) {
    checkUserAuth();
  }

  Future<void> checkUserAuth() async {
    /// this is where you can check if you have the cached token on the phone
    /// on app startup
    /// for now we assume no such caching is done
    ///

    var userString = await _storage.read(key: "activeUser");
    if (userString != null && userString.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(userString);

      var user = UserModel.fromJson(userMap);

      state = AuthState.authenticated(user);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> loginUser(String email, String password) async {
    state = AuthState.loading();

    UserModel user = await repo.loginUser(email, password);

    if (user == UserModel.empty) {
      state = const AuthState.unauthenticated();
    } else {
      /// do your pre-checks about the user before marking the state as
      /// authenticated
      state = AuthState.authenticated(user);
    }
  }

  Future<void> loginGoogleUser(
      String email, String userId, String firstName, String lastName) async {
    state = AuthState.loading();

    UserModel user =
        await repo.loginGoogleUser(email, userId, firstName, lastName);

    if (user == UserModel.empty) {
      state = const AuthState.unauthenticated();
    } else {
      /// do your pre-checks about the user before marking the state as
      /// authenticated
      state = AuthState.authenticated(user);
    }
  }

  Future<void> loginFacebookUser(
      String email, String userId, String firstName, String lastName) async {
    state = AuthState.loading();

    UserModel user =
        await repo.loginFacebookUser(email, userId, firstName, lastName);

    if (user == UserModel.empty) {
      state = const AuthState.unauthenticated();
    } else {
      /// do your pre-checks about the user before marking the state as
      /// authenticated
      state = AuthState.authenticated(user);
    }
  }

  Future<void> logoutUser() async {
    await repo.logoutUser();
    state = const AuthState.unauthenticated();
  }

  AppRepository repo;
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(ref));
