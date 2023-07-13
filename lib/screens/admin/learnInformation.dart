import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LearnInformation extends StatefulWidget {
  const LearnInformation({super.key});

  @override
  State<LearnInformation> createState() => _LearnInformationState();
}

class _LearnInformationState extends State<LearnInformation> {
  ImagePicker imagePicker = ImagePicker();
  File? image;
  VideoPlayerController? _videoplayercontroller;
  File? _video;
  pickVideo() async {
    final video = await imagePicker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _videoplayercontroller = VideoPlayerController.file(_video!)
      ..initialize()
          .then((_) => {setState(() {}), _videoplayercontroller!.play()});
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceDirImagesToUpload = referenceDirImages.child(uniqueName);

    try {
      await referenceDirImagesToUpload.putFile(File(video.path));
      imageUrl = await referenceDirImagesToUpload.getDownloadURL();
    } catch (error) {}
  }

  uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    print(file!.path);
    final imagetemporary = File(file.path);
    if (file == null) return;
    setState(() {
      image = imagetemporary;
    });
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceDirImagesToUpload = referenceDirImages.child(uniqueName);

    try {
      await referenceDirImagesToUpload.putFile(File(file.path));
      imageUrl = await referenceDirImagesToUpload.getDownloadURL();
    } catch (error) {}
  }

  CollectionReference reference =
      FirebaseFirestore.instance.collection('learnInformation');
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var descriptioncontroller = TextEditingController();

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
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
              hintText: 'Enter your Description',
              contentPadding: EdgeInsets.only(left: 15, top: 60),
              border: OutlineInputBorder(),
              label: Text('Enter your Description')),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Row(children: [
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 79,
              width: 79,
              color: Color.fromRGBO(237, 237, 237, 1),
              child: IconButton(
                onPressed: () async {
                  [pickVideo()];
                },
                icon: Icon(Icons.add),
                color: Color.fromARGB(255, 48, 41, 41),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        // Container(
        //   child: Column(
        //     children: [
        if (_video != null)
          _videoplayercontroller!.value.isInitialized
              ? Container(
                  height: 100,
                  width: 100,
                  child: AspectRatio(
                      aspectRatio: _videoplayercontroller!.value.aspectRatio,
                      child: VideoPlayer(_videoplayercontroller!)),
                )
              : Container(),
        Container(
            height: 79,
            width: 79,
            child: image != null ? Image.file(image!) : null),
        //     ],
        //   ),
        // ),
        //     Container(
        //         height: 79,
        //         width: 79,
        //         child: _video!=null?
        //         _videoplayercontroller!.value.isInitialized?AspectRatio(aspectRatio:_videoplayercontroller!.value.aspectRatio,
        //         child: VideoPlayer(_videoplayercontroller!) )
        //         // image != null ? Image.file(image!) :  null

        // :Container()),

        SizedBox(
          height: 40,
        ),
      ]),
      ElevatedButton(
          onPressed: () async {
            try {
              CollectionReference collRef =
                  FirebaseFirestore.instance.collection('learnInformation');

              if (titlecontroller.text.isNotEmpty &&
                  descriptioncontroller.text.isNotEmpty &&
                  imageUrl.isNotEmpty) {
                await collRef.add({
                  'title': titlecontroller.text,
                  'description': descriptioncontroller.text,
                  'image': imageUrl
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Details Sent Successfully!')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please add the valid details!')));
              }
            } catch (e) {
              print(e.toString());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('There was an error sending the details!')));
            }
            setState(() {
              titlecontroller.clear();
              descriptioncontroller.clear();
            });
            // if (imageUrl.isEmpty) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text('Please upload an image')));
            //   return;
            // }
            // CollectionReference collref =
            //     FirebaseFirestore.instance.collection('learnInformation');
            // collref.add({
            //   'title': titlecontroller.text,
            //   'description': descriptioncontroller.text,
            //   'image': imageUrl
            // });
          },
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 20),
          ))
    ])));
  }
}
