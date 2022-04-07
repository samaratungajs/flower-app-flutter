import 'package:crud_app/screens/admin/quiz/add_quiz_screen.dart';
import 'package:crud_app/screens/admin/quiz/list_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
              child: QuestionList(name),
            ),
          ),
        ));
  }
}
