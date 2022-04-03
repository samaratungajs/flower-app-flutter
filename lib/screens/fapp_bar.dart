import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String sectionName;
  const AppBarTitle({
    Key? key,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/firebase_logo.png',
          height: 20,
        ),
        const Text(
          'FlutterFire',
          style: TextStyle(color: Colors.yellowAccent, fontSize: 18),
        ),
        Text(
          '$sectionName ',
          style: const TextStyle(
            color: Colors.orangeAccent,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
