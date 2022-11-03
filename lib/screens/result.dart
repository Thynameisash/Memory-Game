import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorygame/screens/score.dart';
import 'package:memorygame/utils/colors.dart';

class UserResult extends StatefulWidget {
  const UserResult({
    super.key,
    required this.usersublist,
    required this.allwords,
  });
  final List<String> usersublist;
  final List<String> allwords;
  @override
  State<UserResult> createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  Color anscolor = ConstColors.defaultanscolor;
  bool correct = false;
  int idx = 0;
  int clicks = 10;
  Map<String, int> wordinlist = {};
  @override
  void initState() {
    super.initState();
    for (String word in widget.allwords) {
      wordinlist.putIfAbsent(word, () => 0);
    }
    // print(wordinlist);
  }

  bool iscorrect(String word) {
    if (--clicks <= 0) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          widget.allwords.shuffle();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserScore(userscoremap: wordinlist,)),
          );
        },
      );
    }
    // clicks--;
    print(clicks);
    if (widget.usersublist.contains(word)) {
      wordinlist[word] = 1;
      // print(wordinlist);
      return true;
    }
    wordinlist[word] = -1;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Check Answers",
          style: GoogleFonts.orbitron(
              fontSize: 30,
              color: ConstColors.primarytext,
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        shadowColor: Colors.black45,
        backgroundColor: ConstColors.primaryc,
      ),
      backgroundColor: ConstColors.primaryc,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.00),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: widget.allwords.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  idx = index;
                  correct = iscorrect(widget.allwords[index]);
                  setState(() {});
                },
                child: Card(
                  color: wordinlist[widget.allwords[index]] == 0
                      ? ConstColors.defaultanscolor
                      : wordinlist[widget.allwords[index]] == 1
                          ? ConstColors.correctanscolor
                          : ConstColors.wronganscolor,
                  child: Center(
                    child: Text(
                      widget.allwords[index],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
