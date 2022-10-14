import 'package:flutter/material.dart';

import '../theme/theme.dart';

inputDecoration(String hint) => InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: const OutlineInputBorder(),
      hintText: hint,
      hintStyle: darkTheme.textTheme.bodyText2!
          .copyWith(color: darkTheme.disabledColor),
      counterStyle: darkTheme.textTheme.bodyText2!
          .copyWith(color: darkTheme.disabledColor, fontSize: 12),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    );
