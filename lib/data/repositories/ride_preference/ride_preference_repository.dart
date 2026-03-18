import 'package:blabla/model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  // history stay in repo cuz it need persistencies
  List<RidePreference> get preferenceHistory;

  void addPreferenceToHistory(RidePreference preference);
}
