import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final List<RidePreference> _preferenceHistory = [];

  final int maxAllowedSeats = 8;

  @override
  List<RidePreference> get preferenceHistory => _preferenceHistory;

  @override
  void addPreferenceToHistory(RidePreference preference) {
    int index = _preferenceHistory.indexOf(preference);

    // if same pref, remove it before put it on top
    if (index != -1) {
      //print("found $preference at $index");
      _preferenceHistory.removeAt(index);
    }

    _preferenceHistory.insert(0, preference);
  }
}
