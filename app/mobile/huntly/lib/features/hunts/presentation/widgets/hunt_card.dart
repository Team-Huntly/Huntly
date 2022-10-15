import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:huntly/features/hunts/presentation/pages/hunt_view.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../authentication/data/models/user_model.dart';

class HuntCard extends StatelessWidget {
  // final String title;
  // final String location;
  // final int seatsLeft;
  // final DateTime start;
  final TreasureHunt treasureHunt;

  const HuntCard({Key? key, required this.treasureHunt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(10);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HuntView(
                    treasureHunt: treasureHunt,
                  )));
        },
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: treasureHunt.started_at.isBefore(DateTime.now())
                      ? darkTheme.indicatorColor
                      : darkTheme.highlightColor,
                  width: 5,
                ))),
                child: Container(
                  width: 90,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: borderRadius, bottomLeft: borderRadius),
                    color: darkTheme.colorScheme.secondary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(treasureHunt.started_at.day.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(DateFormat('MMM').format(treasureHunt.started_at),
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      Text(DateFormat('HH:MM').format(treasureHunt.started_at),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: borderRadius, bottomRight: borderRadius),
                    color: darkTheme.colorScheme.primary,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            treasureHunt.name,
                            style: darkTheme.textTheme.headline3,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                // treasureHu``,
                                'hello',
                                style: TextStyle(
                                  color: darkTheme.colorScheme.secondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${treasureHunt.total_seats - treasureHunt.participants.length} seats left",
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
      ),
    );
  }
}
