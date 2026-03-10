import 'package:flutter/material.dart';
import '../models/registrant_model.dart';

class RegistrationProvider extends ChangeNotifier {

  final List<Registrant> _registrants = [];

  bool _isDarkMode = false;
  MaterialColor _themeColor = Colors.indigo;

  bool get isDarkMode => _isDarkMode;
  MaterialColor get themeColor => _themeColor;

  List<Registrant> get registrants => List.unmodifiable(_registrants);
  int get count => _registrants.length;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeThemeColor(MaterialColor color) {
    _themeColor = color;
    notifyListeners();
  }

  void addRegistrant(Registrant registrant) {
    _registrants.add(registrant);
    notifyListeners();
  }

  void removeRegistrant(String id) {
    _registrants.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  Registrant? getById(String id) {
    try {
      return _registrants.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  bool isEmailRegistered(String email) {
    return _registrants.any(
      (r) => r.email.toLowerCase() == email.toLowerCase(),
    );
  }

  void sortByName() {
    _registrants.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }
}