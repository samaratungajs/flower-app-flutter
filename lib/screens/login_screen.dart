import 'package:crud_app/screens/login_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=> _uidFocusNode.unfocus(),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 30.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/robot.png',
                                height: 160,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Flower Pedia',
                            style: TextStyle(
                              color: Color.fromARGB(255, 33, 182, 137),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const Text(
                          //   'Pedia',
                          //   style: TextStyle(
                          //     color: Colors.orange,
                          //     fontSize: 40,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // )
                        ],
                      )),
                      FutureBuilder(
                          future: _initializeFirebase(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error initilizing firebase");
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return LoginForm(focusNode: _uidFocusNode);
                            }
                            return const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orangeAccent),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
