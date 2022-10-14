import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class ActionButton extends StatelessWidget {
  final String? text;
  final String? leading;
  final Function() onTap;
  final Color? color;
  final Alignment? alignment;

  const ActionButton({
    Key? key,
    this.text,
    this.leading,
    required this.onTap,
    this.color,
    this.alignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: color ?? darkTheme.highlightColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                leading != null
                  ? Padding(
                    padding: EdgeInsets.only(right: text != null ? 10 : 0),
                    child: Iconify(
                      leading!,
                      color: Colors.white,
                    ),
                  )
                  : Container(),
                text != null 
                  ? Text(
                    text!,
                    style: darkTheme.textTheme.button,
                  )
                  : Container(width: 0)
              ],
            )
          ),
        ),
      ),
    );
  }
}