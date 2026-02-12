import 'package:blabla/ui/screens/date_picker/date_picker_screen.dart';
import 'package:blabla/ui/screens/location_picker/location_picker_screen.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/ride_prefs_form_tile.dart';
import 'package:blabla/ui/screens/seat_picker/seat_picker_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    requestedSeats = 1;
    departureDate = DateTime.now();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref?.departure;
      arrival = widget.initRidePref?.arrival;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void swapLocation() {
    if (departure != null || arrival != null) {
      setState(() {
        Location? temp = arrival;
        arrival = departure;
        departure = temp;
      });
    }
  }

  void pickDeparture() async {
    final result = await Navigator.push<Location>(
        context,
        MaterialPageRoute(
          builder: (_) =>  LocationPickerScreen(initLocation: departure,),
        ));

    if (result != null) {
      setState(() {
        departure = result;
      });
    }
  }

  void pickArrival() async {
   final result = await Navigator.push<Location>(
        context,
        MaterialPageRoute(
          builder: (_) =>  LocationPickerScreen(initLocation: arrival,),
        ));

    if (result != null) {
      setState(() {
        arrival = result;
      });
    }
  }

  void pickDate() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DatePickerScreen(),
        ));
  }

  void pickSeat() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SeatPickerScreen(),
        ));
  }

  void search() {}

  void onSearch() {
    if (departure == null) return pickDeparture();
    if (arrival == null) return pickArrival();

    return search();
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormTile(
                leadIcon: Icons.circle_outlined,
                title: departure != null ? departure?.name : "Leaving from",
                isFilled: departure != null,
                action: () => {pickDeparture()},

                // the real app hide the swap button until one of the location is selected -> swapped cant be tested until location picker works
                trailingIcon: departure != null
                    ? IconButton(
                        onPressed: () => swapLocation(),
                        icon: Icon(
                          Icons.swap_vert,
                          color: BlaColors.primary,
                        ),
                      )
                    : null),
            BlaDivider(),
            FormTile(
              leadIcon: Icons.circle_outlined,
              title: arrival != null ? arrival?.name : "Going to",
              isFilled: arrival != null,
              action: () => {pickArrival()},
            ),
            BlaDivider(),
            FormTile(
              leadIcon: Icons.calendar_month_outlined,
              title: DateTimeUtils.formatDateTime(departureDate),
              isFilled: true,
              action: pickDate,
            ),
            BlaDivider(),
            FormTile(
              leadIcon: Icons.person_outlined,
              title: requestedSeats.toString(),
              isFilled: true,
              action: pickSeat,
            ),
            BlaButton(
              title: "Search",
              action: onSearch,
              isRounded: false,
            )
          ]),
    );
  }
}
