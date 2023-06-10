import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picpuzzal/level_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'level_page.dart';

class Game_Play extends StatefulWidget {
  int game_level;

  Game_Play(this.game_level);

  @override
  State<Game_Play> createState() => _Game_PlayState();
}

class _Game_PlayState extends State<Game_Play> {
  List all_img = [];
  bool tamp = false;
  List Puzzal_img = [];
  int a = 5;
  bool stop=false;
  List<bool> Temp_time = [];
  int pos1 = 0, pos2 = 0;
  int click = 1;
  SharedPreferences? prefs;
  bool time = true;
  int cn=0;
  int store_time=0;
  List level_count=[12,16,20,24,28,32,36,40,44,48];


  Future Get_img() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      all_img = imagePaths;
      all_img.shuffle();
      for (int i = 0; i < level_count[widget.game_level]/2; i++) {
        Puzzal_img.add(all_img[i]);
        Puzzal_img.add(all_img[i]);
      }
      Puzzal_img.shuffle();
      tamp = true;
    });
  }

  Set_Timer() async {  //for hid the all slid after show it
    for (int i = 5; i >= 0; i--) {
      a = i;
      if (i == 0) {
        Temp_time = List.filled(level_count[widget.game_level], false);
        print(a);
        print(Temp_time);
      }
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
    }
    for (int j = 0; j <= 100; j++) { // after the open store time and stop time
      if(stop==true)
        {
          break;
        }
      a = j;
      await Future.delayed(Duration(seconds: 1));

      setState(() {});
      time = true;
    }

     }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Temp_time = List.filled(level_count[widget.game_level], true);
    Set_Timer();
    Get_img().then((value) {});
    st_pos();
    }

  st_pos() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("NO TIME LIMIT :- ${a}"),
        backgroundColor: Color(0xff009788),
      ),
      body: (tamp)
          ? Container(
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.4,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          itemCount: level_count[widget.game_level],
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (Temp_time[index] == false) //for hind index
                    {
                  //Temp_time[index] = true; //for open index
                  if (click == 1 && Temp_time[index]==false) {
                    Temp_time[index] = true;
                    pos1 = index;
                    click = 0;
                    Future.delayed(Duration(milliseconds: 10))
                        .then((value) {
                      click = 2;

                    });

                  }
                  if (click == 2 &&Temp_time[index]==false ) {
                    Temp_time[index] = true;
                    pos2 = index;
                    //click=0;
                    if (Puzzal_img[pos1] == Puzzal_img[pos2]) {
                      prefs!.setString("levelstatus${widget.game_level}", "win");
                      cn++;

                    } else {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) {
                        Temp_time[pos1] = false;
                        Temp_time[pos2] = false;
                        print(pos1);
                        print(pos2);
                        setState(() {});
                      });
                    }
                    click=1;
                  }
                  setState(() {});
                  store_time=a;

                  if(cn==level_count[widget.game_level]/2) {

                    setState(() {
                      stop=true;
                    });

                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Congrluaction!!!"), actions: [
                        TextButton(onPressed: () {

                          prefs!.setInt('time${widget.game_level}', store_time);

                          widget.game_level++;
                          prefs!.setInt('win_levelno', widget.game_level);
                          prefs!.setString("Win_status${widget.game_level}", "Win_status");

                          setState(() {});
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Leval_page();
                              },));
                        }, child: Text("ok"))
                      ],);
                    },);
                  }
                }
              },
              child: Visibility(
                visible: Temp_time[index],
                replacement: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Color(0xff009788),
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage("${Puzzal_img[index]}")),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            );
          },
        ),
      )
          : CircularProgressIndicator(),
    ), onWillPop: () async{

      showDialog(context: context, builder: (context) {
          return AlertDialog(title: Text("Are you sure for exit..."),
            actions: [
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return Leval_page();
                    },));
                  }, child: Text("Yes")),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("No")),
            ],
          );
      },);
      return true;
    },);
  }
}
