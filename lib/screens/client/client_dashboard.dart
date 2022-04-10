import 'package:crud_app/screens/admin/category/admin_home.dart';
import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/quiz/quiz_home.dart';
import 'package:crud_app/screens/client/quiz/quiz_screen.dart';
import 'package:crud_app/screens/client/categories/category_list.dart';
import 'package:crud_app/screens/client/flowers/user_fhome.dart';
import 'package:crud_app/screens/client/q&a_forum/qa_home.dart';
import 'package:flutter/material.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Home",
            
          ),
        ),
        body: Container(
          padding:EdgeInsets.all(20),
        child: GridView(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Categories())),
              child: Container(
                decoration: BoxDecoration(border:Border.all(width: 3.0,color: Color.fromARGB(148, 31, 196, 155)) ,borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt_rounded, size: 50, color: Color.fromARGB(148, 31, 196, 155),),
                    Text("Categories", style: TextStyle(color: Color.fromARGB(148, 31, 196, 155), fontSize:25,fontWeight: FontWeight.bold,)
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserHome())),
              child: Container(
                decoration: BoxDecoration(border:Border.all(width: 3.0,color: Color.fromARGB(148, 31, 196, 155)), borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.line_style_rounded, size: 50, color:Color.fromARGB(148, 31, 196, 155),),
                    Text("Flowers", style: TextStyle(color: Color.fromARGB(148, 31, 196, 155), fontSize:25,fontWeight: FontWeight.bold,)
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => QAHome())),
              child: Container(
                decoration: BoxDecoration(border:Border.all(width: 3.0,color: Color.fromARGB(148, 31, 196, 155)), borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded, size: 50, color: Color.fromARGB(148, 31, 196, 155),),
                    Text("Q & A \n Forum", style: TextStyle(color: Color.fromARGB(148, 31, 196, 155), fontSize:25,fontWeight: FontWeight.bold,)
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => QuizScreen())),
              child: Container(
                decoration: BoxDecoration(border:Border.all(width: 3.0,color: Color.fromARGB(148, 31, 196, 155)), borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.quiz_rounded, size: 50, color: Color.fromARGB(148, 31, 196, 155),),
                    Text("Quiz", style: TextStyle(color: Color.fromARGB(148, 31, 196, 155), fontSize:25,fontWeight: FontWeight.bold,)
                    ),
                  ],
                ),
              ),
            ),
          ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing:15,crossAxisSpacing: 15 ),
        ),
        ),
    );
  }
}