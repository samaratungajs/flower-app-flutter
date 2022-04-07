// import 'package:crud_app/screens/add_screen.dart';
import 'package:crud_app/screens/admin_header_with_search.dart';
// import 'package:crud_app/screens/item_list.dart';
import 'package:crud_app/screens/admin/quiz/list_quiz.dart';
import 'package:crud_app/screens/admin/quiz/add_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  String name = "";
  final fieldText = TextEditingController();
  bool _isDeleting = false;

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
                .push(MaterialPageRoute(builder: (context) => AddQuizScreen()));
          },
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
        body: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                //Admin header with search
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: size.height * 0.21,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.21 - 27,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 29, 177, 152),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36))),
                        child: Row(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                          ),
                          Text(
                            'Quiz questions',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Padding(
                  padding: EdgeInsets.only(right: 30,),
          
                      child: Image.asset(
                        "assets/whitelogo.png",
                        height: 40,
                      )),
                        ]),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 20),
                                    blurRadius: 50,
                                    color: Color.fromARGB(31, 65, 65, 65))
                              ]),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Search Title",
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              132, 60, 146, 120)),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                ),
                              ),
                              Icon(
                                Icons.search,
                                color: Color.fromARGB(132, 60, 146, 120),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Admin header with search

                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
                  child: QuestionList(name),
                ),
              ]),
            ),
          ),
        ));
  }

}
