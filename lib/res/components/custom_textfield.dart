import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? lebaltitle;
  final Color? color;
  final TextInputType? keyboardType;
  final Widget? textFieldIcon;
  final double textsize;
  final TextEditingController? textStore;

  const CustomTextfield(
      {required this.textFieldIcon,
      this.color,
      this.textStore,
      required this.textsize,
      this.lebaltitle,
      this.keyboardType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: textStore,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.blueGrey.shade100,
          filled: true,
          prefixIcon: textFieldIcon,
          labelText: lebaltitle,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: textsize,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50, // Default border color
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            // Border when focused
            borderSide: BorderSide(
              color: Colors
                  .black, // Focused border color (darker shade for emphasis)
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            // Border when enabled (not focused)
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50, // Enabled border color
            ),
          ),
        ),
      ),
    );
  }
}
