import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:homework14/services/api_result.dart';

class GuessAge extends StatefulWidget {
  static const routeName = '/home';
  const GuessAge({Key? key}) : super(key: key);

  @override
  _GuessAgeState createState() => _GuessAgeState();

}

class _GuessAgeState extends State<GuessAge> {
  int _year = 0;
  int _month = 0;
  int ans_year = 30;
  int ans_mon = 5;

  var _isload = false;
  static const BASE_URL ="https://cpsu-test-api.herokuapp.com/guess_teacher_age";
  void minus() {
    setState(() {
      if (_year != 0) {
        _year--;
      }
    });
  }

  void add() {
    setState(() {
      _year++;
    });
  }

  void minus2() {
    setState(() {
      if (_month !=0) {
        _month--;
      }
    });
  }

  void add2() {
    setState(() {
      if (_month != 12) {
        _month++;
      }
    });
  }

  guess(){

      if (_year == ans_year && _month == ans_mon) {
        Navigator.pushReplacementNamed(context, Answer.routeName);
      } else {
        if (_year <= ans_year) {
          if (_month >= ans_mon) {
            _showMaterialDialog("ไม่ถูกต้อง", "ทายมากไป");
          } else {
            _showMaterialDialog("ไม่ถูกต้อง","ทายน้อยไป",);
          }
        } else {
          _showMaterialDialog("ไม่ถูกต้อง", "ทายมากไป");
        }
      }

  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> submit(
      String endPoint,
      Map<String, dynamic> params,
      ) async {
    var url = Uri.parse('$BASE_URL/$endPoint');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json'
      },
      body: json.encode(params),
    );

    if (response.statusCode == 500) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      print('RESPONSE BODY: $jsonBody');

      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.status == 'ok') {
        return apiResult.data;
      } else {
        throw apiResult.message!;
      }
    } else {
      throw 'Server connection failed!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("GUESS TEACHER'S AGE",style: TextStyle(fontSize: 40.0),),
        backgroundColor: Colors.pinkAccent
      ),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "อายุของอาจารย์"
              ),
                  Column(
                    children: [
                      Text(
                          "ปี",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: minus,
                            child: const Icon(Icons.remove, color: Colors.black,),
                            backgroundColor: Colors.white,),

                          Text('$_year',
                              style: const TextStyle(fontSize: 60.0)),

                          FloatingActionButton(
                            onPressed: add,
                            child: const Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,),
                        ],

                      ),

                      Text(
                          "เดือน"
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: minus2,
                            child: const Icon(Icons.remove, color: Colors.black,),
                            backgroundColor: Colors.white,),

                          Text('$_month',
                              style: const TextStyle(fontSize: 60.0)),

                          FloatingActionButton(
                            onPressed: add2,
                            child: const Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 48), // takes postional arguments as width and height
                          ),
                            onPressed: (){
                                  guess();
                            },
                            child: Text('ทาย',style: TextStyle(fontSize: 30.0),)),
                      )
                    ],
                  ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "ตัวอย่างนี้กำหนดเป็น 30 ปี 5 เดือน"
                ),
              ),
                ]
              ),
          ),
    );
  }
}
class Answer extends StatefulWidget {
  static const routeName = '/correct';

  const Answer({Key? key}) : super(key: key);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  var _ansyear = 30;
  var _ansmonth = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "GUESS TEACHER'S AGE",
              style: TextStyle(fontSize: 40.0),
            ),

          ],
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "ทายถูกต้อง",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "อายุ $_ansyear ปี $_ansmonth เดือน",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Icon(
                Icons.check_circle_sharp,
                size: 100.0,
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



