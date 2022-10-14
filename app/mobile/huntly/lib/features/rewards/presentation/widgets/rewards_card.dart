import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/core/utils/action_button.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../../../../core/theme/theme.dart';

class RewardsCard extends StatelessWidget {
  final String imageLocation;
  final String orgName;
  final String description;
  final String code;
  final String link;

  const RewardsCard(
      {Key? key,
      required this.imageLocation,
      required this.orgName,
      required this.description,
      required this.code,
      required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white))),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: borderRadius, bottomLeft: borderRadius),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imageLocation,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(orgName,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: darkTheme.colorScheme.background))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: borderRadius, bottomRight: borderRadius),
                color: darkTheme.colorScheme.primary,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(description,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              height: 1.2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ActionButton(
                              text: 'Claim now',
                              onTap: () {},
                              fontSize: 14,
                              borderRadius: 100),
                          const SizedBox(width: 10),
                          const Iconify(
                            Ic.twotone_content_copy,
                            color: Colors.white,
                          )
                        ],
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
