import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class UserScore extends StatefulWidget {
  const UserScore({super.key, required this.userscoremap, required this.name});
  final Map<String, int> userscoremap;
  final String name;
  @override
  State<UserScore> createState() => _UserScoreState();
}

class _UserScoreState extends State<UserScore> {
  int finalscore = 0;
  CollectionReference leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');
  Map<String, dynamic> userFullData = {};
  List<Map<String, String>> leaderboardsdata = [];
  bool isloading = true;
  String currUserName = "";

  @override
  void initState() {
    super.initState();
    currUserName = widget.name;
    for (int i in widget.userscoremap.values) {
      if (i == 1) {
        finalscore++;
      }
    }
    addinfo();
  }

  //Add info to firebase
  addinfo() {
    return leaderboard.add(
      {
        "name": widget.name,
        "score": finalscore,
      },
    ).then((value) {
      getleaderboards();
      return value;
    }).catchError(
      (error) => print("Failed to add user: $error"),
    );
  }

// Fetch all leaderboards from firebase as a list of Map<Name, Score>
  void getleaderboards() async {
    await leaderboard.get().then(
      (value) {
        for (var i in value.docs) {
          leaderboardsdata.add({
            "name": i["name"],
            "score": i["score"].toString(),
          });
        }
      },
    );
    // Sort leaderboards in desc to highlight top scorer.
    leaderboardsdata.sort((b, a) => (a['score'])!.compareTo(b['score']!));
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Results",
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  //HR below Appbar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 2.0,
                      width: width,
                      color: ConstColors.secondarytext,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Your Score: $finalscore",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 30, color: ConstColors.primarytext),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "||| LEADERBOARDS |||",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, color: ConstColors.primarytext),
                      ),
                    ),
                  ),
                  for (int i = 0; i < leaderboardsdata.length; i++)
                    FavouriteListView(
                      name: leaderboardsdata[i]["name"]!,
                      finalscore: leaderboardsdata[i]["score"].toString(),
                      currUserName: currUserName,
                      // List is sorted, First guy will the top scorer in leaderboard.
                      winner: i == 0 ? true : false,
                    ),
                ],
              ),
            ),
    );
  }
}

class FavouriteListView extends StatefulWidget {
  const FavouriteListView(
      {super.key,
      required this.name,
      required this.finalscore,
      required this.currUserName,
      required this.winner});
  final String name;
  final String finalscore;
  final String currUserName;
  final bool winner;
  @override
  State<FavouriteListView> createState() => _FavouriteListViewState();
}

class _FavouriteListViewState extends State<FavouriteListView> {
  @override
  Widget build(BuildContext context) {
    TextStyle headingStyle = const TextStyle(
      color: Colors.white,
    );
    TextStyle descriptionStyle = const TextStyle(color: Colors.white);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: widget.currUserName == widget.name
                ? ConstColors.scorehighligtcolor
                : ConstColors.primaryc,
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: ListTile(
              title: Text(
                widget.name,
                style: headingStyle,
              ),
              subtitle: Text(
                widget.finalscore.toString(),
                style: descriptionStyle,
              ),
              leading: Icon(
                widget.winner ? Icons.workspace_premium_outlined : Icons.person,
                color: ConstColors.primarytext,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
