import 'package:flutter/material.dart';
import 'phone_body.dart';  // Import phone layout
import 'tablet_body.dart';  // Import tablet layout

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const TabletBody();  // Load tablet layout
        } else {
          return const PhoneBody();  // Load phone layout
        }
      },
    );
  }
}
