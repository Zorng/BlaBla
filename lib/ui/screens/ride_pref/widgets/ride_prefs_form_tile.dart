import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class FormTile extends StatelessWidget {
  final String? title;
  final VoidCallback action;
  final IconData leadIcon;
  final IconButton? trailingIcon;
  final bool isFilled;
  const FormTile(
      {super.key,
      required this.leadIcon,
      required this.title,
      required this.action,
      required this.isFilled,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    final Color color =
        isFilled ? BlaColors.neutralDark : BlaColors.neutralLight;
    final TextStyle textStyle = BlaTextStyles.body.copyWith(color: color);
    return ListTile(
        onTap: action,
        leading: Icon(leadIcon, color: textStyle.color),
        title: Text(
          title!,
          style: textStyle,
        ),
        trailing: trailingIcon);
  }
}
