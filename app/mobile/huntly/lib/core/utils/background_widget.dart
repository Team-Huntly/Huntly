import 'package:flutter/material.dart';

class BackGroundWidget extends StatefulWidget {
  String title;
  BackGroundWidget({super.key, required this.title});

  @override
  State<BackGroundWidget> createState() => _BackGroundWidgetState();
}

class _BackGroundWidgetState extends State<BackGroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
      child: Column(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              "assets/images/home-placeholder-map.png",
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Text(widget.title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal)),
          )
        ],
      ),
    );
  }
}
