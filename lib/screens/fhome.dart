import 'package:crud_app/screens/add_fscreen.dart';
import 'package:crud_app/screens/admin_fhome.dart';
import 'package:crud_app/screens/fapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/fitem_list.dart';
import 'admin_header_with_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 67, 88),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            clearText();
            setState(() {
              name = "";
            });
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            controller: fieldText,
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddFScreen()));
        },
        backgroundColor: Color.fromARGB(255, 255, 177, 10),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          ItemList(name)
          //   Padding(
          //  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
          //  child: ItemList(name),
          //  ),
        ],
      )
          // child: Padding(
          //   padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
          //   child: ItemList(name),
          // ),
          ),
    );
  }
}
