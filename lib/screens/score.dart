import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class UserScore extends StatefulWidget {
  const UserScore({super.key, required this.userscoremap});
  final Map<String, int> userscoremap;
  @override
  State<UserScore> createState() => _UserScoreState();
}

class _UserScoreState extends State<UserScore> {
  int finalscore = 0;
  @override
  void initState() {
    super.initState();
    for (int i in widget.userscoremap.values) {
      if (i == 1) {
        finalscore++;
      }
    }
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
      body: Center(
        child: Text(
          "Bhai TERA SCORE HAI \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t${finalscore}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
