import 'package:crud_app/screens/add_fscreen.dart';
import 'package:crud_app/screens/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/fitem_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amberAccent,
          title: const AppBarTitle(sectionName: 'CRUD'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => AddFScreen())),
              );
            },
            backgroundColor: Colors.orangeAccent,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            )),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
            child:ItemList(),

          ),
        ));
  }
}
