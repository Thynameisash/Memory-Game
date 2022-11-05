import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memorygame/screens/info.dart';
import 'package:memorygame/utils/colors.dart';
import 'firebase_options.dart';
import 'utils/apiservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewPage(),
    );
  }
}

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Word Game",
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
      body: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> allwords = [];
  @override
  void initState() {
    super.initState();
    apicall();
  }

  apicall() async {
    allwords = await ApiService.callApi();
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
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
            padding: const EdgeInsets.only(top: 180),
            child: Text(
              "Pls select a difficulty level",
              style: GoogleFonts.orbitron(
                  fontSize: 30, color: ConstColors.primarytext),
            ),
          ),

          //Easy BTN
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: const GradientBtn(
                timedelay: 2000,
                difficulty: "Easy",
              ),
            ),
          ),

          //Medium BTN
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: const GradientBtn(
                timedelay: 1000,
                difficulty: "Medium",
              ),
            ),
          ),

          //Hard BTN
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: const GradientBtn(
                timedelay: 500,
                difficulty: "Hard",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBtn extends StatefulWidget {
  const GradientBtn({
    Key? key,
    required this.timedelay,
    required this.difficulty,
  }) : super(key: key);
  final int timedelay;
  final String difficulty;
  @override
  State<GradientBtn> createState() => _GradientBtnState();
}

class _GradientBtnState extends State<GradientBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserInfo(
              timedelay: widget.timedelay,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        padding: const EdgeInsets.all(0.0),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ConstColors.primarytext, ConstColors.gradientcolor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            widget.difficulty,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
