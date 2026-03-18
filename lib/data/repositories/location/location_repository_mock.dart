import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/model/ride/locations.dart';

class LocationRepositoryMock implements LocationRepository {
  final List<Location> _availableLocations = fakeLocations;

  @override
  List<Location> getLocations() {
    return _availableLocations;
  }
}
