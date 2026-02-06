import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> _filterByDeparture(Location departure, List<Ride> rides) {
    return rides.where((pref) => pref.departureLocation == departure).toList();
  }

  static List<Ride> _filterBySeatRequested(
      int seatRequested, List<Ride> rides) {
    return rides.where((pref) => pref.remainingSeats >= seatRequested).toList();
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    List<Ride> result = allRides;

    if (departure != null) result = _filterByDeparture(departure, result);

    if (seatRequested != null) result = _filterBySeatRequested(seatRequested, result);

    return result;
  }
}
// filter by seat
// filter by des
