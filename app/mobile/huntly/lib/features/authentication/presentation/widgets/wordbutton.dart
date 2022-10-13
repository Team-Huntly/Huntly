import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants.dart';

// class WordButton extends StatelessWidget {
//   final Interests word;
//   bool isSelected ;
//   WordButton({required this.word , required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isSelected = !isSelected;
//         });
//       },
//       child: UnconstrainedBox(
//           child: Container(
//               margin: const EdgeInsets.all(5.0),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.blue,
//                 ),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Row(
//                 children: [
//                   // icon
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
//                     child: word.icon,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Center(
//                       child: Text(
//                         word.interest,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ))),
//     );
//   }
// }

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
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  // icon

                  Container(
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: widget.isSelected
                        ? Icon(Icons.cancel)
                        : widget.word.icon,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        widget.word.interest,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
