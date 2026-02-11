import 'package:flutter/material.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';

void main() {
  runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(
          body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: SizedBox(
            width: 400,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlaButton(
                  action: () {},
                  title: "Hello",
                  iconData: Icons.ac_unit_sharp,
                ),
                BlaButton(
                  action: () {},
                  title: "Hello",
                  iconData: Icons.alarm,
                ),
                BlaButton(
                  action: () {},
                  title: "Hello",
                  iconData: Icons.alarm,
                  isPrimary: false,
                ),
                BlaButton(
                  action: () {},
                  title: "Dragona",
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
