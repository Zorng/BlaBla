import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/location_service.dart';
import 'package:blabla/services/ride_prefs_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  final Location? initLocation;
  const LocationPickerScreen({super.key, this.initLocation});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final SearchController _controller = SearchController();

  @override
  void initState() {
    if (widget.initLocation != null) {
      _controller.text = widget.initLocation!.name;
    } else {
      _controller.text = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle hintStyle =
        BlaTextStyles.body.copyWith(color: BlaColors.neutralLight);

    final TextStyle textStyle =
        BlaTextStyles.body.copyWith(color: BlaColors.neutralDark);

    final TextStyle labelStyle =
        BlaTextStyles.label.copyWith(color: BlaColors.neutral);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchAnchor.bar(
              // onChanged: (value) => update(list),
              searchController: _controller,

              //    We need to write both bar styling and view styling
              // because the when we tap on the search bar to write
              // it transform to view styling

              // bar styling
              dividerColor: Colors.transparent,
              barElevation: WidgetStatePropertyAll(0),
              barBackgroundColor: WidgetStatePropertyAll(BlaColors.white),
              barPadding:
                  WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
              barTextStyle: WidgetStatePropertyAll(textStyle),
              barHintStyle: WidgetStatePropertyAll(hintStyle),
              barHintText: 'Station Road or The Bride Cafe',
              barLeading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.chevron_left, color: BlaColors.neutralDark)),

              //view styling
              viewShape: null,
              viewElevation: 0,
              viewBackgroundColor: BlaColors.white,
              viewBarPadding: EdgeInsets.symmetric(horizontal: 8),
              viewHeaderHintStyle: hintStyle,
              viewHeaderTextStyle: textStyle,
              viewLeading: IconButton(
                  onPressed: () {
                    // we need to by pass the close view because the default behavoir of tapping
                    // leading view is closing the view not poping like the bar lead
                    _controller.closeView(null);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.chevron_left, color: BlaColors.neutralDark)),

              viewBuilder: (suggestions) {
                final list = suggestions.toList();
                return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const BlaDivider(),
                    itemBuilder: (context, index) => list[index]);
              },

              //    SugestionsBuilder create the suggestions used in the viewBuilder.
              // Here we can nicely create listTile dynamically like the history tile
              // and search result tile. very handy!
              suggestionsBuilder:
                  (BuildContext context, SearchController searchController) {
                // we more the filter logic here because rendering the result list with the onChanged above resulted in 1 keydown late
                final input = searchController.text;
                final filteredHistory = RidePrefsService.uniqueLocationsHist
                    .where((loc) =>
                        loc.name.toLowerCase().startsWith(input.toLowerCase()))
                    .toList();

                // Filter available locations based on current input
                final List<Location> filteredResults = input.isEmpty
                    ? []
                    : LocationsService.availableLocations
                        .where((loc) => loc.name
                            .toLowerCase()
                            .startsWith(input.toLowerCase()))
                        .toList();

                return [
                  ...filteredHistory.map((location) {
                    return ListTile(
                        onTap: () => {
                              // since the view is actually opened form the bar,
                              //the pop will actually close the view. Since we need
                              //to exit the screen on select we need to by pass the default
                              //behavior by manaully writing a closeview
                              searchController.closeView(null),
                              Navigator.pop(context, location)
                            },
                        leading: Icon(
                          Icons.history,
                          color: BlaColors.neutralDark,
                        ),
                        title: Text(
                          location.name,
                          style: textStyle,
                        ),
                        subtitle: Text(
                          location.country.name,
                          style: labelStyle,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: BlaColors.neutral,
                        ));
                  }),
                  ...filteredResults.map((location) {
                    return ListTile(
                      onTap: () => {
                        // since the view is actually opened form the bar,
                        //the pop will actually close the view. Since we need
                        //to exit the screen on select we need to by pass the default
                        //behavior by manaully writing a closeview
                        searchController.closeView(null),
                        Navigator.pop(context, location)
                      },
                      title: Text(
                        location.name,
                        style: textStyle,
                      ),
                      subtitle: Text(
                        location.country.name,
                        style: labelStyle,
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: BlaColors.neutral,
                      ),
                    );
                  }),
                ];
              },
            ),
          )
        ],
      ),
    );

    // void updateList(String input) {
    //   if (input.isEmpty || input == '') {
    //     print("empty");
    //     setState(() {
    //       historyHit = RidePrefsService.uniqueLocationsHist;
    //       print(historyHit);
    //     });
    //   } else {
    //     setState(() {
    //       historyHit = RidePrefsService.uniqueLocationsHist
    //           .where((location) =>
    //               location.name.toLowerCase().startsWith(input.toLowerCase()))
    //           .toList();
    //     });
    //   }
    //   setState(() {
    //     searchResult = LocationsService.availableLocations
    //         .where((location) =>
    //             location.name.toLowerCase().startsWith(input.toLowerCase()))
    //         .toList();
    //   });
    // }
  }
}
