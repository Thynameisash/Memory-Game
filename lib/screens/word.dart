import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/screens/result.dart';

class MyWord extends StatefulWidget {
  const MyWord({super.key, required this.allwords, required this.timedelay});
  final List<String> allwords;
  final int timedelay;
  @override
  State<MyWord> createState() => _MyWordState();
}

class _MyWordState extends State<MyWord> {
  int idx = 0;

  String currWord = "";
  @override
  void initState() {
    super.initState();
    List<String> usersublist = widget.allwords.sublist(0, 10);
    Timer.periodic(
      Duration(seconds: widget.timedelay),
      (timer) {
        if (idx == usersublist.length) {
          timer.cancel();
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UserResult(
                    usersublist: usersublist,
                    allwords: widget.allwords,
                  ),
                ),
              );
            },
          );
        }
        setState(
          () {
            currWord = usersublist[idx];
            idx++;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PADHLE"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Center(
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromARGB(255, 248, 210, 205),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Center(
                        child: Text(
                      currWord,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
