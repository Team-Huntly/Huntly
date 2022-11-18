import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../core/theme/theme.dart';

class HuntInfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String info;
  final String? trailing;
  final double? fontSize;

  const HuntInfoCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.info,
      this.trailing,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // width: MediaQuery.of(context).size.width * 0.39,
      decoration: BoxDecoration(
          color: darkTheme.colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 2, offset: Offset(1, 2)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Iconify(
                icon,
                color: darkTheme.colorScheme.secondary,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: darkTheme.colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              trailing != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Iconify(
                        trailing!,
                        color: darkTheme.highlightColor,
                        size: 15,
                      ),
                    )
                  : Container()
            ],
          ),
          Text(info,
              style: darkTheme.textTheme.headline2!
                  .copyWith(fontSize: fontSize ?? 16))
        ],
      ),
    );
  }
}
