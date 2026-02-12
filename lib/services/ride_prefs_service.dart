import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///
class RidePrefsService {
  static RidePref? selectedRidePref; // The current selected ride preference

  static List<RidePref> ridePrefsHistory = fakeRidePrefs;

  // a SET of location counted from both Dept and Arr of RidePrefHistory
  // if no hit, -> set of all
  // if hit -> set ot hit location

  static final List<Location> _departures = fakeRidePrefs.map((r) => r.departure).toList();
  static final List<Location> _arrivals = fakeRidePrefs.map((r) => r.arrival).toList();

  static Set<Location> get uniqueLocationSet => {..._departures, ..._arrivals};

  static List<Location> uniqueLocationsHist = uniqueLocationSet.toList();
  
}
