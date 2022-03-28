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
        // Image.asset(
        //   'assets/whitelogo.png',
        //   height: 10,
        // ),
        const SizedBox(width: 8),
          Text(
                'Add Category',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}

