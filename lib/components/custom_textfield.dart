import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? lebaltitle;
  final FocusNode? focusNode;
  final Color? color;
  final String? Function(String?)? validator;
  final void Function(String)? onfieldSubmission;
  final TextInputType? keyboardType;
  final Widget? textFieldIcon;
  final double textsize;
  final TextEditingController? textStore;

  const CustomTextfield(
      {required this.textFieldIcon,
      this.color,
      this.validator,
      this.onfieldSubmission,
      this.focusNode,
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
        validator: validator,
        focusNode: focusNode,
        controller: textStore,
        keyboardType: keyboardType,
        onFieldSubmitted: onfieldSubmission,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
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
              color: Colors.grey.shade200, // Default border color
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
              color: Colors.grey.shade200, // Enabled border color
            ),
          ),
        ),
      ),
    );
  }
}
