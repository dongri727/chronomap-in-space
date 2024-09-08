import 'package:chronomap_in_space/utils/shadowed_container.dart';
import 'package:chronomap_in_space/utils/theme.dart';
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

///Vertically aligned RadioButton showing choices
class RadioButtonFormat extends StatefulWidget {
  final List<String> options;
  final String? initialOption;
  final ValueChanged<String?> onChanged;

  const RadioButtonFormat({
    super.key,
    required this.options,
    this.initialOption,
    required this.onChanged,
  });

  @override
  State<RadioButtonFormat> createState() => _RadioButtonFormatState();
}

class _RadioButtonFormatState extends State<RadioButtonFormat> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShadowedContainer(
            child: ListTile(
              title: Text(
                option,
              ),
              leading: Radio<String>(
                //activeColor: Colors.yellow,
                value: option,
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
