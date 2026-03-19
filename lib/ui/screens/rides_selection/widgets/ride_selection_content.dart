import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/view_model/ride_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../../utils/animations_util.dart' show AnimationUtils;

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///

class RidesSelectionContent extends StatelessWidget {
  final RideSelectionViewModel viewModel;
  const RidesSelectionContent({super.key, required this.viewModel});

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> onFilterPressed(BuildContext context) async {
    final selectedFilter = await showModalBottomSheet<RideFilterOption>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: Text(
                'Filter rides',
                style: BlaTextStyles.title.copyWith(
                  color: BlaColors.textNormal,
                ),
              ),
            ),
            for (final option in RideFilterOption.values)
              ListTile(
                title: Text(option.label),
                trailing:
                    viewModel.selectedFilter == option ? const Icon(Icons.check) : null,
                onTap: () => Navigator.of(context).pop(option),
              ),
          ],
        ),
      ),
    );

    if (selectedFilter == null || selectedFilter == viewModel.selectedFilter) {
      return;
    }

    viewModel.selectFilter(selectedFilter);
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
      viewModel.preferenceState.currentRidePref!;

  List<Ride> get matchingRides {
    final rides = List<Ride>.of(
      viewModel.getRidesFor(selectedRidePreference),
    );

    switch (viewModel.selectedFilter) {
      case RideFilterOption.earliestDeparture:
        rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
        break;
      case RideFilterOption.lowestPrice:
        rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
        break;
      case RideFilterOption.mostAvailableSeats:
        rides.sort((a, b) => b.remainingSeats.compareTo(a.remainingSeats));
        break;
    }

    return rides;
  }

  void onPreferencePressed(BuildContext context) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference =
        await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createRightToLeftRoute(
        RidePreferenceModal(initialPreference: selectedRidePreference),
      ),
    );

    if (newPreference != null) {
      viewModel.preferenceState.selectPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: () {
                onBackTap(context);
              },
              onFilterPressed: () {
                onFilterPressed(context);
              },
              onPreferencePressed: () {
                onPreferencePressed(context);
              },
            ),
            SizedBox(height: 100),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) => Expanded(
                child: ListView.builder(
                  itemCount: matchingRides.length,
                  itemBuilder: (ctx, index) => RideSelectionTile(
                    ride: matchingRides[index],
                    onPressed: () => onRideSelected(matchingRides[index]),
                  ),
                ),
              )
            
            ),
          ],
        ),
      ),
    );
  }
}
