import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState preferenceState;
  late List<RidePreference> _history;

  HomeViewModel({required this.preferenceState}) {
    preferenceState.addListener(notifyListeners);

    _init();
  }

  List<RidePreference> get history => _history;

  @override
  void dispose() {
    preferenceState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() {
    _history = preferenceState.repo.preferenceHistory;
    notifyListeners();
  }

  void selectPreference(RidePreference preference) {
    preferenceState.selectPreference(preference);

    notifyListeners();
  }
}
