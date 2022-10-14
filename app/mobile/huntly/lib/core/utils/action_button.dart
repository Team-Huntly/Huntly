import 'package:flutter/material.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class ActionButton extends StatelessWidget {
  final String? text;
  final String? leading;
  final Function() onTap;
  final Color? color;
  final Alignment? alignment;
  final bool colorIcon;
  final double? fontSize;
  final double? borderRadius;

  const ActionButton({
    Key? key,
    this.text,
    this.leading,
    required this.onTap,
    this.color,
    this.alignment,
    this.colorIcon=true,
    this.fontSize,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;

    return Align(
      alignment: alignment ?? Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: color ?? darkTheme.highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
            ),
            child: Row(
              children: [
                leading != null
                  ? Padding(
                    padding: EdgeInsets.only(right: text != null ? 10 : 0),
                    child: colorIcon
                      ? Iconify(
                        size: iconSize,
                        leading!,
                        color: Colors.white,
                      )
                      : Iconify(
                        size: iconSize,
                        leading!,
                      )
                  )
                  : Container(),
                text != null 
                  ? Text(
                    text!,
                    style: darkTheme.textTheme.button!.copyWith(
                      fontSize: fontSize ?? 18,
                    ),
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