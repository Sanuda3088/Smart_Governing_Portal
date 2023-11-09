import 'package:flutter/material.dart';
import 'package:smart_governing_portal/Responsive/DesktopSite/after_Registration_Page.dart';
import 'package:smart_governing_portal/Responsive/DesktopSite/home_page.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AfterRegistrationPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}