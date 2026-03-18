import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/data/repositories/location/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/data/repositories/ride/ride_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:blabla/main_common.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get devProviders {
  RidePreferenceRepository ridePreferenceRepository =
      RidePreferenceRepositoryMock();
  return [
    Provider<LocationRepository>(create: (_) => LocationRepositoryMock()),
    Provider<RideRepository>(create: (_) => RideRepositoryMock()),
    ChangeNotifierProvider<RidePreferenceState>(
        create: (_) =>
            RidePreferenceState(repo: ridePreferenceRepository))
  ];
}

void main() {
  mainCommon(devProviders);
}
