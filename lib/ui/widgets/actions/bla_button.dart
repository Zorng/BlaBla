import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final IconData? iconData;
  final bool isPrimary;
  final bool isRounded;
  const BlaButton(
      {super.key,
      required this.title,
      required this.action,
      this.iconData,
      this.isPrimary = true,
      this.isRounded = true,
      });

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isPrimary ? BlaColors.backgroundAccent : BlaColors.primary;

    final TextStyle textStyle = BlaTextStyles.button.copyWith(color: textColor);

    final Color backGroundColor =
        isPrimary ? BlaColors.primary : BlaColors.white;

    final BorderSide? borderSide =
        isPrimary ? null : BorderSide(color: BlaColors.backgroundAccent);

    final Color? feedbackColor =
        isPrimary ? null : BlaColors.neutralLight.withAlpha(5);

    final RoundedRectangleBorder? shape = isRounded? null : RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(
      topLeft: Radius.zero,
      topRight: Radius.zero,
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12)

    ))
    ;

    return FilledButton(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: shape ,
        backgroundColor: backGroundColor,
        side: borderSide,
        overlayColor: feedbackColor,
      ),
      onPressed: action,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData != null ? Icon(iconData, color: textColor) : SizedBox(),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
