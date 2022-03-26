import 'package:crud_app/screens/add_screen.dart';
import 'package:crud_app/screens/app_bar.dart';
import 'package:crud_app/screens/item_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 67, 88),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const AppBarTitle(
          sectionName: "CRUD",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddScreen()));
        },
        backgroundColor: Color.fromARGB(255, 255, 177, 10),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
              child: ItemList(),
              ),
              ),
    );
  }
}
