import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteaider/screens/admin/dustbinPage.dart';

class DustbinLocationList extends StatefulWidget {
  const DustbinLocationList({super.key});

  @override
  State<DustbinLocationList> createState() => _DustbinLocationListState();
}

class _DustbinLocationListState extends State<DustbinLocationList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference? listTileCollection;

  @override
  void initState() {
    super.initState();
    listTileCollection = firestore.collection('dustbin');
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
                        builder: (context) => DustbinPage(),
                      ));
                },
              ),
            ]),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              'List of Locations',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('dustbin').snapshots(),
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
                              document['latitude'].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 10, left: 20, right: 10),
                            subtitle: Text(
                              document['location'].toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
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
                                icon: Icon(Icons.delete))),
                      );
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
