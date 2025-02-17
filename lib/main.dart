import 'dart:async'; // Importing Timer

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0A66C2)),
        useMaterial3: false,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController =
      PageController(viewportFraction: 0.9); // PageController

  var certificationProgramImages = [
    "course3.jpg",
    "course3.jpg",
    "course3.jpg",
    "course3.jpg",
    "course3.jpg",
    "course3.jpg",
    "course3.jpg",
  ];

  var onlineCoursesImages = [
    "course2.jpg",
    "course2.jpg",
    "course2.jpg",
    "course2.jpg",
    "course2.jpg",
    "course2.jpg",
    "course2.jpg",
  ];

  // Timer for auto-page change
  late Timer _timer;
  int _currentPage = 0; // Track current page index

  @override
  void initState() {
    super.initState();
    // Start a timer to change the page every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < certificationProgramImages.length - 1) {
        _currentPage++; // Increment page index
      } else {
        _currentPage = 0; // **Loop back to the first page**
      }

      _pageController.animateToPage(
        _currentPage, // Animate to the next page
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  void showCoursePopup(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          "assets/images/$imagePath",
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Course Details",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text("This is a detailed description of the course."),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0A66C2),
          title: Text("Courses Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.5, // Half screen height
                child: PageView(
                  controller: _pageController, // Using the PageController
                  children: [
                    Image.asset("assets/images/ban4.jpg"),
                    Image.asset("assets/images/ban5.jpg"),
                    Image.asset("assets/images/ban6.jpg"),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A66C2),
                  ),
                  onPressed: () {},
                  child: Text("Enrolled Courses")),
              SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Certification Program",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.all(3.0),
                    padding: EdgeInsets.all(5.0),
                    height: 160, // Ensures ListView has a defined height
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.0), // Reduce padding
                                child: SizedBox(
                                  height: 100,
                                  width: 190,
                                  child: Image.asset(
                                    "assets/images/${certificationProgramImages[index]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text("Course Name"),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF0A66C2),
                                  ),
                                  onPressed: () {
                                    showCoursePopup(context,
                                        certificationProgramImages[index]);
                                  },
                                  child: Text("Get Now"))
                            ],
                          ),
                        );
                      },
                      itemCount: certificationProgramImages.length,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 200,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Online Courses",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(5.0),
                        height: 160, // Ensures ListView has a defined height
                        width: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.0), // Reduce padding
                                    child: SizedBox(
                                      height: 100,
                                      width: 190,
                                      child: Image.asset(
                                        "assets/images/${onlineCoursesImages[index]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text("Course Name"),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF0A66C2),
                                      ),
                                      onPressed: () {
                                        showCoursePopup(context,
                                            onlineCoursesImages[index]);
                                      },
                                      child: Text("Get Now"))
                                ],
                              ),
                            );
                          },
                          itemCount: onlineCoursesImages.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 200,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
