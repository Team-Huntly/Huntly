import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_view.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';

class HuntCard extends StatelessWidget {
  final String title;
  final String location;
  final int seatsLeft;
  final DateTime start;

  const HuntCard({
    Key? key,
    required this.title,
    required this.location,
    required this.seatsLeft,
    required this.start}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);

    return GestureDetector(
      onTap: () {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HuntView()));
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                        color: start.isBefore(DateTime.now())
                          ? darkTheme.indicatorColor
                          : darkTheme.highlightColor,
                        width: 5,
                      )
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius),
                    color: darkTheme.colorScheme.secondary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        start.day.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      Text(
                        DateFormat('MMM').format(start),
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                        )
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat('HH:MM').format(start),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: borderRadius, bottomRight: borderRadius),
                  color: darkTheme.colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Container(
                    child: Text(
                      title,
                      style: darkTheme.textTheme.headline3,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          location,
                          style: TextStyle(
                            color: darkTheme.colorScheme.secondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$seatsLeft seats left",
                        style: TextStyle(
                          color: darkTheme.colorScheme.secondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
