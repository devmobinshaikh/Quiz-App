import 'package:flutter/material.dart';
import 'package:mobiquiz/home.dart';

class result extends StatefulWidget {
  int marks = 0;
  result({Key? key, required this.marks}) : super(key: key);

  @override
  _resultState createState() => _resultState(marks);
}

class _resultState extends State<result> {
  int marks = 0;
  _resultState(this.marks);

  List<String> resultimg = [
    'assets/images/1st.webp',
    'assets/images/second.jpg',
    'assets/images/loser.jpg',
  ];
  String image = "";
  String msg = "";
  @override
  void initState() {
    // TODO: implement initState
    if (marks > 35) {
      image = resultimg[0];
      msg = "You did WELL...\n" + "your Score is $marks";
    } else if (marks > 20 && marks < 35) {
      image = resultimg[1];
      msg = "You can do BETTER...\n" + "Your Score is $marks";
    } else {
      image = resultimg[2];
      msg = "You should try Hard...\n" + "Your Score is $marks";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Material(
            elevation: 15.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Image(
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(msg,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: "Cursive",
                          fontSize: 30.0),
                      textAlign: TextAlign.center),
                ),
                MaterialButton(
                  elevation: 5,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => home()),
                    );
                  },
                  height: 60,
                  minWidth: 250,
                  splashColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.only(top: 30),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Material(
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         elevation: 15.0,
                //         child: Container(
                //           color: Colors.white,
                //           alignment: Alignment.center,
                //           child: MaterialButton(
                //             onPressed: () {},
                //             height: 60,
                //             minWidth: 250,
                //             splashColor: Colors.lightGreen,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             color: Colors.white,
                //             child: Text(
                //               "OK",
                //               style: TextStyle(fontSize: 30.0),
                //             ),
                //           ),
                //         ),
                // //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
