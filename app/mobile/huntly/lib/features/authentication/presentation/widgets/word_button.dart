import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/emojione_v1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';

class WordButton extends StatefulWidget {
  final Interests word;
  bool isSelected;
  ValueNotifier<List<Interests>> selectedWords;
  WordButton(
      {required this.word,
      required this.isSelected,
      required this.selectedWords});
  @override
  State<WordButton> createState() => _WordButtonState();
}

class _WordButtonState extends State<WordButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isSelected) {
          print(widget.selectedWords.value.length);
          widget.selectedWords.value.add(widget.word);
        } else {
          widget.selectedWords.value.remove(widget.word);
        }
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        print(widget.selectedWords.value);
      },
      child: UnconstrainedBox(
          child: Container(
              padding: const EdgeInsets.only(right: 5),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkTheme.highlightColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: widget.isSelected
                    ? darkTheme.highlightColor
                    : darkTheme.colorScheme.background,
              ),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                      child: Iconify(
                        widget.isSelected ? Ic.round_cancel : widget.word.icon,
                        // color: widget.isSelected
                        //     ? Colors.white
                        //     : Colors.transparent)
                      )),
                  const SizedBox(width: 5),
                  Center(
                    child: Text(widget.word.interest,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: Colors.white,
                        letterSpacing: 2)),
                  ),
                ],
              ))),
    );
  }
}
