import 'package:flutter/material.dart';
import 'package:wasteaider/screens/user/findBinPage.dart';
import 'package:wasteaider/screens/user/findWasteCollector.dart';
import 'package:wasteaider/screens/user/learn.dart';
import 'package:wasteaider/screens/user/learnInformationList.dart';

class UserChoose extends StatefulWidget {
  const UserChoose({super.key});

  @override
  State<UserChoose> createState() => _UserChooseState();
}

class _UserChooseState extends State<UserChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_sharp)),
            ),
            Padding(padding: EdgeInsets.only(top: 150)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindBinPage()),
                  );
                },
                child: Text(
                  'Find Bin',
                  style: TextStyle(fontSize: 30),
                )),
            Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FindWasteCollector()),
                  );
                },
                child: Text('Find Waste Collector',
                    style: TextStyle(fontSize: 30))),
            Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserLearnInformation()),
                  );
                },
                child: Text('Learn', style: TextStyle(fontSize: 30)))
          ],
        ),
      ),
    );
  }
}
