import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorygame/screens/result.dart';

import '../utils/colors.dart';

class MyWord extends StatefulWidget {
  const MyWord(
      {super.key,
      required this.allwords,
      required this.timedelay,
      required this.name,
      required this.usersublist});
  final String name;
  final List<String> allwords;
  final int timedelay;
  final List<String> usersublist;
  @override
  State<MyWord> createState() => _MyWordState();
}

class _MyWordState extends State<MyWord> {
  int idx = 0;
  String currWord = "";
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    //Timer to display each word after a delay
    Timer.periodic(
      Duration(milliseconds: widget.timedelay),
      (timer) {
        if (idx == widget.usersublist.length) {
          timer.cancel();
          //Another timer for the last word.
          Future.delayed(
            Duration(milliseconds: widget.timedelay),
            () {
              widget.allwords.shuffle();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UserResult(
                    usersublist: widget.usersublist,
                    allwords: widget.allwords,
                    name: widget.name,
                  ),
                ),
              );
            },
          );
        }
        setState(
          () {
            isloading = false;
            currWord = widget.usersublist[idx];
            if (idx != widget.usersublist.length) {
              idx++;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Words",
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
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: ConstColors.secondarytext,
                strokeWidth: 8,
              ),
            )
          : UserInfoBody(width: width, currWord: currWord),
    );
  }
}

class UserInfoBody extends StatelessWidget {
  const UserInfoBody({
    Key? key,
    required this.width,
    required this.currWord,
  }) : super(key: key);

  final double width;
  final String currWord;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //<hr> below Appbar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 2.0,
            width: width,
            color: ConstColors.secondarytext,
          ),
        ),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
