import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class ViewTab extends StatelessWidget {
  final String icon;

  const ViewTab({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Iconify(
        icon,
        color: Colors.white,
        size: 30,
      ),
      
    );
  }
}