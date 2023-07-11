import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteaider/screens/user/learn.dart';

class UserLearnInformation extends StatefulWidget {
  const UserLearnInformation({super.key});

  @override
  State<UserLearnInformation> createState() => _UserLearnInformationState();
}

class _UserLearnInformationState extends State<UserLearnInformation> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference? listTileCollection;

  @override
  void initState() {
    super.initState();
    listTileCollection = firestore.collection('learnInformation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'List of Information',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('learnInformation')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      String documentId = document.id;

                      return Container(
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Learn(
                                          document: document,
                                        )),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                document['title'].toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 20, right: 10),
                              subtitle: Text(
                                document['description'].toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              leading: Image.network('${document['image']}'),
                            ),
                          ));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error fetching data');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
