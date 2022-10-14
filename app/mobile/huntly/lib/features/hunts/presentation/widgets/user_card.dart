import 'package:flutter/material.dart';
import 'package:huntly/features/authentication/data/models/user_model.dart';

import '../../../../core/theme/theme.dart';
import '../../data/models/team_model.dart';

class UserCard extends StatelessWidget {
  UserModel user;
  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: darkTheme.colorScheme.background,
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(2, 2)),
          ]),
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/images/1.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.firstName,
                style: darkTheme.textTheme.headline2!.copyWith(fontSize: 16),
              ),
              Text(
                user.email,
                style: darkTheme.textTheme.headline3!.copyWith(
                    fontSize: 14, color: darkTheme.colorScheme.secondary),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
