import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

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
          child: Column(
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
                    'This is the Title',
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
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Image(
                  width: double.infinity,
                  height: 190,
                  image: AssetImage('assets/images/location.png'),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  ''' A location is the place where a particular point or object exists. Location is an important term in geography, and is usually considered more precise than "place." A locality is a human settlement: city, town, village, or even archaeological site.
                    
                    A place's absolute location is its exact place on Earth, often given in terms of latitude and longitude.
                    
                    For example, the Empire State Building is located at 40.7 degrees north (latitude), 74 degrees west (longitude). It sits at the intersection of 33rd Street and Fifth Avenue in New York City, New York, United States. That is the building’s absolute location.
                    
                    Location can sometimes be expressed in relative terms. Relative location is a description of how a place is related to other places. For example, the Empire State Building is 365 kilometers (227 miles) north of America's White House in Washington, D.C. It is also about 15 blocks from New York's Central Park. These are just two of the building's relative locations.
                    
                    Relative location can help analyze how two places are connected, whether by distance, culture, or even technology. The city of Kiev, Ukraine, for example, is about 2,298 kilometers (1,428 miles) east of London, England. The U.S. cities of Key West, Florida, and Anchorage, Alaska, are even further apart—6,436 kilometers (3,999 miles). However, Floridians and Alaskans share the same language, national government, and geographic features. (They both have long ocean coasts subject to heavy storms, for instance.). Culturally, Ukraine and England are much further apart than the U.S. states of Florida and Alaska: They speak different languages, have different government systems, and different geographic features. (Ukraine is landlocked, for instance, while England is part of the island nation of the United Kingdom.)''',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
