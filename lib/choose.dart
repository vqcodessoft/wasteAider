import 'package:flutter/material.dart';
import 'package:wasteaider/admin/adminchooseDustbinWastecollector.dart';

import 'package:wasteaider/user/userChoose.dart';

class ChooseUserAdmin extends StatefulWidget {
  const ChooseUserAdmin({super.key});

  @override
  State<ChooseUserAdmin> createState() => _ChooseUserAdminState();
}

class _ChooseUserAdminState extends State<ChooseUserAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 350)),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserChoose()),
                  );
                },
                child: Text(
                  'User',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseDustbinWasteCollector()),
                );
              },
              child: Text('Admin', style: TextStyle(fontSize: 30)))
        ],
      ),
    );
  }
}
