import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class SeatPickerScreen extends StatefulWidget {
  final int initSeat;
  const SeatPickerScreen({super.key, required this.initSeat});

  @override
  State<SeatPickerScreen> createState() => _SeatPickerScreenState();
}

class _SeatPickerScreenState extends State<SeatPickerScreen> {
  late int seat;

  Color get removeBtnColor => seat > 1 ? BlaColors.primary : BlaColors.disabled;

  Color get addBtnColor => seat < 8 ? BlaColors.primary : BlaColors.disabled;

  @override
  void initState() {
    seat = widget.initSeat;
    super.initState();
  }

  void removeSeat() {
    if (seat > 1) {
      setState(() {
        seat--;
      });
    }
  }

  void addSeat() {
    if (seat < 8) {
      setState(() {
        seat++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = BlaTextStyles.heading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: BlaColors.primary,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Number of seats to book",
              style: textStyle.copyWith(color: BlaColors.neutralDark),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: removeSeat,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: removeBtnColor,
                    )),
                Text(
                  seat.toString(),
                  style: BlaTextStyles.heading,
                ),
                IconButton(
                    onPressed: addSeat,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: addBtnColor,
                    )),
              ],
            )),
            Center(
              child: BlaButton(
                title: "Confirm",
                action: () => Navigator.pop(context, seat),
              ),
            )
          ],
        ),
      ),
    );
  }
}
