import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'level_page.dart';

void main() {
  runApp(MaterialApp( debugShowCheckedModeBanner: false,
    home: DeshBord(),
  ));
}

class DeshBord extends StatefulWidget {
  const DeshBord({Key? key}) : super(key: key);

  @override
  State<DeshBord> createState() => _DeshBordState();
}

class _DeshBordState extends State<DeshBord> {
  List allimag = [];
  bool tamp = false;
  List puz_imag = [];


  Future get_img() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      allimag = imagePaths;
      allimag.shuffle();
      for (int i = 0; i < 6; i++) {
        puz_imag.add(allimag[i]);
        puz_imag.add(allimag[i]);
      }
      puz_imag.shuffle();
      //print(allimag);
      tamp = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_img().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("Select Mode"),
        backgroundColor: Color(0xff009788),
        actions: [IconButton(onPressed: () {

        }, icon: Icon(Icons.volume_down),padding: EdgeInsets.only(left: 5),),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert),padding: EdgeInsets.only(left: 5),)
        ],

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 190,
            width: 190,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff009788), width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Leval_page();
                    },));
                  },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff009788),
                      ),
                      child: Text(
                        "NO TIME LIMIT",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff009788),
                    ),
                    child: Text(
                      "NORMAL",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff009788),
                    ),
                    child: Text(
                      "HARD",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(),
          Container(
            height: 50,
            width: 110,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff009788), width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 90,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xff009788),
                    ),
                    child: Text(
                      "Remove Add",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]),
          ),
          SizedBox(),
          Container(
            height: 60,
            width: 300,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff009788), width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Container(alignment: Alignment.center,
                  height: 30,
                  width: 90,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0xff009788),
                  ),
                  child: Text(
                    "Share",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),

                ),
                  Container(alignment: Alignment.center,
                    height: 30,
                    width: 90,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xff009788),
                    ),
                    child: Text(
                      "More Game",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),

                  )]),
          )
        ]),
      ),
    ), onWillPop: () async{
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text("Are you sure you will exist???"),
              actions: [TextButton(onPressed: () {
                Navigator.pop(context);
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
