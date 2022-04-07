import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget{
  final String sectionName;
  const AppBarTitle({Key? key, required this.sectionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/robot.png',
          height: 20,
        ),
        const SizedBox(width: 8),
        const Text(
          'Flower ',
          style: TextStyle(color: Color.fromARGB(255, 255, 177, 10), fontSize: 19),
        ),
        Text(
          sectionName,
          style: const TextStyle(color: Color.fromARGB(255, 158, 223, 255), fontSize: 18),
        ),
      ],
    );
  }
}

