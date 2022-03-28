import 'package:crud_app/screens/add_screen.dart';
import 'package:crud_app/screens/admin_header_with_search.dart';
import 'package:crud_app/screens/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String name = "";
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddScreen()));
          },
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
        body: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
              child: ItemList(name),
            ),
          ),
        )
        );

  }
}
