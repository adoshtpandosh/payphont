const String content = '''import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  AuthState({this.isAuthenticated = false, this.isLoading = false, this.error});

  AuthState copyWith({bool? isAuthenticated, bool? isLoading, String? error}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  late SharedPreferences _prefs;

  AuthNotifier() : super(AuthState()) {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /* ---------- PIN ---------- */

  Future<void> checkPin(String pin) async {
    state = state.copyWith(isLoading: true, error: null);
    final savedPin = _prefs.getString('pin') ?? '0000';
    if (pin == savedPin) {
      state = state.copyWith(isAuthenticated: true, isLoading: false);
    } else {
      state = state.copyWith(
          isAuthenticated: false, isLoading: false, error: 'PIN اشتباه است');
    }
  }

  Future<void> changePin(String oldPin, String newPin) async {
    final savedPin = _prefs.getString('pin') ?? '0000';
    if (oldPin != savedPin) {
      state = state.copyWith(error: 'PIN قبلی اشتباه است');
      return;
    }
    await _prefs.setString('pin', newPin);
    state = state.copyWith(error: null);
  }

  /* ---------- بیومتریک ---------- */

  Future<void> authenticateWithBiometric() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final bool canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) {
        state = state.copyWith(
            isLoading: false,
            error: 'امکان استفاده از بیومتریک وجود ندارد');
        return;
      }
      final bool didAuth = await _localAuth.authenticate(
        localizedReason: 'ورود با اثر انگشت',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      state = state.copyWith(
          isAuthenticated: didAuth, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(
          isAuthenticated: false, isLoading: false, error: e.toString());
    }
  }

  /* ---------- خروج ---------- */

  void logout() {
    state = AuthState(); // reset
  }
}''';