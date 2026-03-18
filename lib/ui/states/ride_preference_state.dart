import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';


// i accidentally completed it in BLA-201 when i read the caution.
class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository repo;
  RidePreferenceState({required this.repo});

  //selected Preference stay in state because it is ephemeral
  RidePreference? _selectedPreference;
  RidePreference? get currentRidePref => _selectedPreference;

  void selectPreference(RidePreference preference) {
    if (_selectedPreference != preference) {
      repo.addPreferenceToHistory(preference);
    }

    notifyListeners();
  }
}
