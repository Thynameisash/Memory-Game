import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorygame/screens/word.dart';
import 'package:memorygame/utils/colors.dart';
import '../utils/apiservice.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key, required this.timedelay});
  final int timedelay;
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController namectr = TextEditingController();
  List<String> allwords = [];

  @override
  void initState() {
    super.initState();
    //prefetch all 24 words to a list, to pass to next screen.
    apicall();
  }

  apicall() async {
    allwords = await ApiService.callApi();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Info",
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
      body: Column(
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
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              width: 600,
              height: 70,
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ConstColors.primarytext),
              ),
              child: TextField(
                style: const TextStyle(
                    color: ConstColors.secondarytext, fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                ),
                controller: namectr,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Container(
              constraints:
                  const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWord(
                        allwords: allwords,
                        timedelay: widget.timedelay,
                        name: namectr.text,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 75, 243, 154),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Proceed to game',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      )
                    ],
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
