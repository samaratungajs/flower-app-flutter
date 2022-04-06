import 'package:flutter/material.dart';

class AdminHeader extends StatefulWidget {
  const AdminHeader({Key? key}) : super(key: key);

  @override
  State<AdminHeader> createState() => _AdminHeaderState();
}

class _AdminHeaderState extends State<AdminHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: size.height * 0.15,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.15 - 27,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 177, 152),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
              ),
              Text(
                'Flower',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // Padding(
              //     padding: EdgeInsets.only(left: 10, right: 18),
              //     child: ClipRRect(
              //         borderRadius: BorderRadius.circular(20),
              //         child: Image.asset(
              //           "assets/whitelogo.png",
              //           height: 30,
              //         ))),
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
                      onChanged: (value) => {},
                      decoration: InputDecoration(
                          hintText: "Search Name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(132, 60, 146, 120)),
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
    );
  }
}
