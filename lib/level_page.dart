import 'package:flutter/material.dart';

import 'package:picpuzzal/data.dart';
import 'package:picpuzzal/game_play.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'game_play.dart';

class Leval_page extends StatefulWidget {

  //Leval_page();

  @override
  State<Leval_page> createState() => _Leval_pageState();
}

class _Leval_pageState extends State<Leval_page> {
  int cur = 0;
  List list = [];
  int time = 0;
  int level = 0;
  List time_List = [];
  bool temp = false;
  List l = [];
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = data.game_level;
    time_List = List.filled(100, "");
    l = List.filled(100, "no");
    get_prf();
  }

  get_prf() async {
    prefs = await SharedPreferences.getInstance();
    cur = prefs!.getInt("win_levelno") ?? 0;
    print("Leval:$cur");
    for (int i = 0; i < 60; i++) {
      l[i] = prefs!.getString("levelstatus$i") ?? "No";
    }
      print(cur);

    for (int i = 0; i < 100; i++) {
      time_List[i] = prefs!.getInt("time$i") ?? "";
    }
    temp = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Level"),
          backgroundColor: Color(0xff009788),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
              padding: EdgeInsets.only(left: 5),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: (temp == true)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.game_level.length,
                  itemBuilder: (context, MyIndex) {
                    return Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 180,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border:
                              Border.all(color: Color(0xff009788), width: 2)),
                      child: Column(children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xff009788), width: 2))),
                          child: Text("${data.game_level[MyIndex]}"),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: double.infinity,
                            width: 150,
                            margin: EdgeInsets.all(10),
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      if ((MyIndex * 10) + index <= cur) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Container(
                                                height: 60,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                color: Color(0xff009788),
                                                child: Text(
                                                  "TIME: NO TIME LIMIT",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              content: Text(
                                                "YOU HAVE 5 SECONDS TO MEMORIES ALL IMAGES",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return Game_Play(
                                                              (MyIndex * 10) +
                                                                  index);
                                                        },
                                                      ));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 30,
                                                            width: 60,
                                                            color: Color(
                                                                0xff009788),
                                                            child: Text(
                                                              "Go",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ],
                                                    ))
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: (l[(MyIndex * 10) + index] == "win")
                                        ? Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 150,
                                            margin: EdgeInsets.all(10),
                                            color: Color(0xff009788),
                                            child: Text(
                                              "LEVEL ${(MyIndex * 10) + (index + 1)} ${time_List[index]}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 150,
                                            margin: EdgeInsets.all(10),
                                            color: (l[(MyIndex * 10) + index] ==
                                                    "win")
                                                ? Color(0xff009788)
                                                : Colors.grey,
                                            child: Text(
                                              "LEVEL ${(MyIndex * 10) + (index + 1)} ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                              },
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                )
              : CircularProgressIndicator(),
        ));
  }
}
