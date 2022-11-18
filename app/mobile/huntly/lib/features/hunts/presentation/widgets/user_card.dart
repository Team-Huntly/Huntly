import 'package:flutter/material.dart';
import 'package:huntly/features/authentication/data/models/user_model.dart';

import '../../../../common/constants.dart';
import '../../../../core/theme/theme.dart';

class UserCard extends StatelessWidget {
  UserModel user;
  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.6,
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
            width: 60,
            height: 60,
            child: Image.network(
              '${url}${user.photoUrl}',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    fontSize: 10, color: darkTheme.colorScheme.secondary),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
