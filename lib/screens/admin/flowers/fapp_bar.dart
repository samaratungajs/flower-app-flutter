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
      children: const [
        // Image.asset(

        //   height: 20,
        // ),
        Text(
          'Add Flower Details',
          style:
              TextStyle(color: Color.fromARGB(255, 9, 75, 103), fontSize: 18),
        ),
      ],
    );
  }
}
