import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteaider/screens/admin/learnInformation.dart';

class ListLearnInformation extends StatefulWidget {
  const ListLearnInformation({super.key});

  @override
  State<ListLearnInformation> createState() => _ListLearnInformationState();
}

class _ListLearnInformationState extends State<ListLearnInformation> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference? listTileCollection;

  @override
  void initState() {
    super.initState();
    listTileCollection = firestore.collection('learnInformation');
  }

  Future<void> deleteListItem(String documentId) async {
    try {
      await listTileCollection!.doc(documentId).delete();
      print('ListTile deleted successfully!');
    } catch (e) {
      print('Error deleting ListTile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearnInformation(),
                      ));
                },
              ),
            ]),
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
                      // Customize the UI as per your requirement
                      return Container(
                          height: 90,
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
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete'),
                                        content: Text(
                                            'Are you sure you want to delete?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              deleteListItem(documentId);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // deleteListItem(documentId);
                                },
                                icon: Icon(Icons.delete)),
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
