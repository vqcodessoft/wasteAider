import 'package:flutter/material.dart';
import 'package:wasteaider/screens/admin/adminchoose.dart';
import 'package:wasteaider/screens/owner/ownerLogIn.dart';
import 'package:wasteaider/screens/user/login.dart';
import 'package:wasteaider/screens/user/signup.dart';

import 'package:wasteaider/screens/user/userChoose.dart';

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
                    MaterialPageRoute(builder: (context) => UserSignup()),
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
              child: Text('Admin', style: TextStyle(fontSize: 30))),
          Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OwnerLogin()),
                );
              },
              child: Text('Owner', style: TextStyle(fontSize: 30)))
        ],
      ),
    );
  }
}
