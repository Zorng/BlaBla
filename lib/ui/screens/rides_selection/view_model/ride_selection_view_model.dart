import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

enum RideFilterOption {
  earliestDeparture('Earliest departure'),
  lowestPrice('Lowest price'),
  mostAvailableSeats('Most available seats');

  const RideFilterOption(this.label);

  final String label;
}

class RideSelectionViewModel extends ChangeNotifier {
  final RidePreferenceState preferenceState;
  final RideRepository repo;
  late RideFilterOption _selectedFilter = RideFilterOption.earliestDeparture;

  RideSelectionViewModel({required this.preferenceState, required this.repo}) {
    preferenceState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    preferenceState.removeListener(notifyListeners);
    super.dispose();
  }

  RideFilterOption get selectedFilter => _selectedFilter;

  List<Ride> getRidesFor(RidePreference preference) {
    return repo.getRidesFor(preference);
  }

  void selectFilter(RideFilterOption filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
