import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> _filterByDeparture(Location departure) {
    return allRides
        .where((pref) => pref.departureLocation == departure)
        .toList();
  }

  static List<Ride> _filterBySeatRequested(int seatRequested) {
    return allRides
        .where((pref) => pref.remainingSeats >= seatRequested)
        .toList();
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> result = [];
    if (departure != null) {
      result.addAll(_filterByDeparture(departure));
    }
    if (seatRequested != null) {
      result.addAll(_filterBySeatRequested(seatRequested));
    }
    

    return result.where((r) => r.departureLocation == departure).toList();
  }
}
// filter by seat
// filter by des
