import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final List<RidePreference> _preferenceHistory = [];

  final int maxAllowedSeats = 8;

  @override
  List<RidePreference> get preferenceHistory => _preferenceHistory;


  @override
  void addPreferenceToHistory(RidePreference preference) {
    _preferenceHistory.add(preference);
  }
}
