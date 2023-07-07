import 'package:flutter/material.dart';

class LearnInformation extends StatelessWidget {
  const LearnInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var descriptioncontroller = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 70, left: 30, right: 30),
              child: Text(
                'Title',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextFormField(
                controller: titlecontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Title',
                    label: Text('Title')),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Description',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: TextFormField(
                controller: descriptioncontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 100, left: 15),
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Description',
                    label: Text('Enter your Description')),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 79,
                  width: 79,
                  color: Color.fromRGBO(237, 237, 237, 1),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    color: Color.fromARGB(255, 48, 41, 41),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
