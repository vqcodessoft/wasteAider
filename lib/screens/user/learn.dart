import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  Learn({super.key, required this.document});

  // ignore: prefer_typing_uninitialized_variables
  var document;
  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: 50),
          child:
              //  StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('learnInformation')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         final List<DocumentSnapshot> documents = snapshot.data!.docs;
              //         return
              Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_sharp)),
                  Padding(padding: EdgeInsets.only(left: 30)),
                  Text(
                    widget.document['title'].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.bottomLeft,
              //   child: IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon: Icon(Icons.arrow_back_ios_new_sharp)),
              // ),
              // Text(
              //   'This is the Title',
              //   textAlign: TextAlign.start,
              //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              // ),
              Container(
                height: 150,
                width: double.infinity,
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Image.network(
                  '${widget.document['image']}',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  widget.document['description'].toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
          //   } else if (snapshot.hasError) {
          //     return Text('Error fetching data');
          //   } else {
          //     return CircularProgressIndicator();
          //   }
          // }),
          ),
    ));
  }
}
