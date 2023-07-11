import 'package:flutter/material.dart';
import 'package:wasteaider/screens/admin/dustbinLocationList.dart';
import 'package:wasteaider/screens/admin/learnInformation.dart';
import 'package:wasteaider/screens/admin/learnInformationList.dart';
import 'package:wasteaider/screens/admin/wasteCollectorLocationList.dart';

class ChooseDustbinWasteCollector extends StatefulWidget {
  const ChooseDustbinWasteCollector({super.key});

  @override
  State<ChooseDustbinWasteCollector> createState() =>
      _ChooseDustbinWasteCollectorState();
}

class _ChooseDustbinWasteCollectorState
    extends State<ChooseDustbinWasteCollector> {
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
                    MaterialPageRoute(
                        builder: (context) => DustbinLocationList()),
                  );
                },
                child: Text(
                  'Add DustBin',
                  style: TextStyle(fontSize: 30),
                )),
            Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => wasteCollectorLocationList()),
                  );
                },
                child: Text('Add Waste Collector',
                    style: TextStyle(fontSize: 30))),
            Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListLearnInformation()),
                  );
                },
                child: Text('Add Learn Information',
                    style: TextStyle(fontSize: 30)))
          ],
        ),
      ),
    );
  }
}
