import 'package:flutter/material.dart';
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
  void iscorrect(String word) {
    if (widget.usersublist.contains(word)) {
      setState(
        () {
          anscolor = ConstColors.correctanscolor;
        },
      );
    } else {
      setState(
        () {
          anscolor = ConstColors.wronganscolor;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Screen"),
      ),
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
                    iscorrect(widget.allwords[index]);
                  },
                  child: Card(
                    color: anscolor,
                    child: Center(child: Text(widget.allwords[index])),
                  ),
                );
              },
            )),
      ),
    );
  }
}
