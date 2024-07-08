import 'package:flutter/material.dart';

//Used for the Add Term Buttons on Input Pages.
class ButtonFormat extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonFormat ({
    required this.label,
    required this.onPressed,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label,
        style: const TextStyle(
            fontSize: 18,
            color: Colors.green),
      ),
    );
  }
}
