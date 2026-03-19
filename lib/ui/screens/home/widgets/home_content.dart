import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/services/ride_prefs_service.dart';
import 'package:blabla/ui/screens/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../utils/animations_util.dart';
import '../../../theme/theme.dart';
import '../../../widgets/pickers/bla_ride_preference_picker.dart';
import '../../rides_selection/rides_selection_screen.dart';
import '../widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeContent extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeContent({super.key, required this.viewModel});

  void onRidePrefSelected(BuildContext context, selectedPreference) async {
    // 1- Ask the service to update the current preference
    //context.read<HomeViewModel>().selectPreference(selectedPreference);
    viewModel.selectPreference(selectedPreference);
    //RidePrefsService.selectPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));

    // 3 - After wait  - Update the state   - TODO Improve this with proper state managagement
    //setState(() {});
  }

  @override
  Widget build(context) {
    return Stack(children: [_buildBackground(), _buildForeground(context)]);
  }

  Widget _buildForeground(BuildContext context) {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: viewModel.preferenceState.currentRidePref,
                onRidePreferenceSelected: (pref) =>
                    //print(viewModel.preferenceState.currentRidePref),
                    onRidePrefSelected(context, pref),
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    // Reverse the history of preferences
    List<RidePreference> history = viewModel.history;
    // List<RidePreference> history =
    // RidePrefsService.preferenceHistory.reversed.toList();
    
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => SizedBox(
        height: 200, // Set a fixed height
        child: ListView.builder(
          shrinkWrap: true, // Fix ListView height issue
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (ctx, index) => HomeHistoryTile(
            ridePref: history[index],
            onPressed: () => onRidePrefSelected(
              ctx,
              history[index],
            ),
          ),
        ),
      ),
    );
    
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
