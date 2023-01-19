import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobiquiz/result.dart';

class jsonloader extends StatelessWidget {
  const jsonloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/python.json'),
        builder: (context, snapshot) {
          List mydata = jsonDecode(snapshot.data.toString());
          if (mydata == null) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            return quizpage(mydata: mydata);
          }
        },
      ),
    );
  }
}

class quizpage extends StatefulWidget {
  final mydata;
  quizpage({Key? key, @required this.mydata}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(mydata: mydata);
}

class _quizpageState extends State<quizpage> {
  List mydata;
  int i = 1;
  Color correct = Colors.green;
  int marks = 0;
  int timer = 30;
  bool canceltimer = false;
  String showtimer = "30";
  Color wrong = Colors.red;
  Color colortoshow = Colors.orangeAccent;
  Map<String, Color> btncolor = {
    "a": Colors.orangeAccent,
    "b": Colors.orangeAccent,
    "c": Colors.orangeAccent,
    "d": Colors.orangeAccent,
  };

  @override
  void initState() {
    // TODO: implement initState
    startTimer();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;

    setState(() {
      if (i < 2) {
        i++;
      } else {
        canceltimer = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => result(marks: marks)),
        );
      }
      btncolor["a"] = Colors.orangeAccent;
      btncolor["b"] = Colors.orangeAccent;
      btncolor["c"] = Colors.orangeAccent;
      btncolor["d"] = Colors.orangeAccent;
    });
    startTimer();
  }

  void checkans(String option) {
    if (mydata[0]["Answer"][i.toString()] == option) {
      print("correct ans");
      marks = marks + 5;
      colortoshow = correct;
    } else {
      print("wrong ans");
      colortoshow = wrong;
    }
    setState(() {
      canceltimer = true;
      btncolor[option] = colortoshow;
      Timer(Duration(seconds: 1), nextquestion);
    });
  }

  Widget options(String k) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () => checkans(k),
                        child: Text(
                          mydata[0]["Options"][i.toString()][k].toString(),
                          // mydata[0]["Options"][1][k],

                          style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: "Times New Roman"),
                          textAlign: TextAlign.left,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        color: btncolor[k],
                        height: 60.0,
                      ),
                    )
                  ],
                )),
          ],
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Alert !"),
                  )
                ],
              ),
              content: Text(
                "Can't leave in-between",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                ),
              ),
              actions: [
                MaterialButton(
                  height: 40,
                  minWidth: 100,
                  splashColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 14.0),
                  ),
                )
              ],
            )));
  }

  _quizpageState({required this.mydata});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    mydata[0]["question"][i.toString()],
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: "Times New Roman"),
                    textAlign: TextAlign.left,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  showtimer,
                  style: TextStyle(fontSize: 35.0, fontStyle: FontStyle.italic, fontFamily: "Cursive"),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    children: [
                      options("a"),
                      options("b"),
                      options("c"),
                      options("d"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
