import 'package:blabla/model/ride/ride.dart';

import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';

void main() {
  Location dijon = Location(country: Country.france, name: "Dijon");

  List<Ride> filteredRide =
      RidesService.filterBy(departure: dijon, seatRequested: 2);

  for (Ride ride in filteredRide) {
    print(ride);
  }
}
