import 'package:agenda_flutter_chareun/client/auth_api.dart' show AuthApi;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final String _email = '';
  bool _isLoggedIn = false;
  final _api = AuthApi();
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;    
    _ready = true;
    notifyListeners();
  }

  //Getters
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
      final token = await _api.login(email, password);

      // Guardar la sesión en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);
      await prefs.setString('email', email);
      await prefs.setBool('isLoggedIn', true);
      _isLoggedIn = true;
      notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('isLoggedIn');
    await prefs.remove('token');

    _isLoggedIn = false;
  }
}
