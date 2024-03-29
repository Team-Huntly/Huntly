import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/theme.dart';

class FormTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextInputType type;
  final TextEditingController controller;

  const FormTextField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.type,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some value';
            }
            return null;
          },
          controller: controller,
          style: darkTheme.textTheme.bodyText2,
          cursorColor: Colors.white,
          keyboardType: type, // Use email input type for emails.
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            hintStyle: darkTheme.textTheme.bodyText2!
                .copyWith(color: darkTheme.disabledColor),
            labelStyle: GoogleFonts.poppins(
              color: darkTheme.disabledColor,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                // TODO: Change inactive border color to white
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
