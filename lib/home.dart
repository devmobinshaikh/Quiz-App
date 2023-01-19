import 'package:flutter/material.dart';
import 'quizpage.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> subject = ["Python", "JavaScript", "C++", "C", "Data\nStructure"];
  List<String> logo = [
    'assets/images/python1.jpg',
    'assets/images/js1.png',
    'assets/images/cpp.png',
    'assets/images/c.png',
    'assets/images/ds1.jpg'
  ];

  List<String> des = [
    "Python is an interpreted,\n object-oriented, \n Python is simple language,",
    "Javascript is a scripting languages,\n primarily used on the Web.\n It is used to enhance HTML pages,",
    "C++ is regarded as a middle-level language, \n as it comprises a combination of both high-level \n and low-level language features.",
    "C is a general-purpose, \n procedural computer programming language \n supporting structured programming",
    "A data structure is a collection of data values, \n A data structure is a named location that \n can be used to store and organize data",
  ];

  Widget customcard(String langname, String logo, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: InkWell(
        splashColor: Colors.amber,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => jsonloader()),
          );
        },
        child: Material(
          color: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 12.0,
          child: Container(
            width: 300,
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(75.0),
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(logo),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    langname,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: "Times New Roman"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    (3),
                  ),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Cursive"),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: ListView(
        children: [
          customcard(subject[0], logo[0], des[0]),
          customcard(subject[1], logo[1], des[1]),
          customcard(subject[2], logo[2], des[2]),
          customcard(subject[3], logo[3], des[3]),
          customcard(subject[4], logo[4], des[4]),
        ],
      ),
    );
  }
}
