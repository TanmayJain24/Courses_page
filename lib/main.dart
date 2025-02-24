import 'dart:async'; // Importing Timer

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

///////////
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

  var certificationProgramVideos = [
    "https://www.youtube.com/watch?v=ovKVqo-L2EM",
    "https://www.youtube.com/watch?v=1IVopxj8q8U",
    "https://www.youtube.com/watch?v=HVjjoMvutj4",
    "https://www.youtube.com/watch?v=ZxKM3DCV2kE",
    "https://www.youtube.com/watch?v=8c6dFc4V5AI",
  ];

  var onlineCoursesVideos = [
    "https://www.youtube.com/watch?v=8c6dFc4V5AI",
    "https://www.youtube.com/watch?v=ZxKM3DCV2kE",
    "https://www.youtube.com/watch?v=HVjjoMvutj4",
    "https://www.youtube.com/watch?v=1IVopxj8q8U",
    "https://www.youtube.com/watch?v=ovKVqo-L2EM",
  ];

  void enrollCourse(String videoUrl) {
    setState(() {
      if (!enrolledCourses.contains(videoUrl)) {
        enrolledCourses.add(videoUrl);
      }
    });
  }

  List<String> enrolledCourses = [];

  String? getYouTubeVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url);
  }

  // Timer for auto-page change
  late Timer _timer;
  int _currentPage = 0; // Track current page index

  @override
  void initState() {
    super.initState();
    // Start a timer to change the page every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < certificationProgramVideos.length - 1) {
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

  void showCoursePopup(
      BuildContext context, String videoUrl, Function enrollCourse) {
    String videoId =
        YoutubePlayer.convertUrlToId(videoUrl)!; // Extract video ID

    bool _isPlayerVisible = false; // Initially, the player is hidden

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: _isPlayerVisible
                                ? YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: videoId,
                                      flags: YoutubePlayerFlags(
                                        autoPlay: true,
                                        mute: false,
                                      ),
                                    ),
                                    showVideoProgressIndicator: true,
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.network(
                                        "https://img.youtube.com/vi/$videoId/maxresdefault.jpg",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.play_circle_filled,
                                            color: Colors.white, size: 50),
                                        onPressed: () {
                                          setState(() {
                                            _isPlayerVisible =
                                                true; // Show video player
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Web Development Full Course",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  "Watch this video to learn more about the course."),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  enrollCourse(videoUrl);
                                  Navigator.pop(context);
                                },
                                child: Text("Enroll Course"),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.35, // Half screen height
                child: PageView(
                  controller: _pageController, // Using the PageController
                  children: [
                    Image.asset("assets/images/ban4.jpg"),
                    Image.asset("assets/images/ban5.jpg"),
                    Image.asset("assets/images/ban6.jpg"),
                  ],
                ),
              ),

              // ✅ **Enrolled Courses Section**
              // **Enrolled Courses Section (Styled like other sections)**

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A66C2),
                  ),
                  onPressed: () {},
                  child: Text("Enrolled Courses")),
              SizedBox(
                height: 0,
              ),

              if (enrolledCourses.isNotEmpty)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20),
                      child: Text(
                        "Enrolled Courses",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.all(3.0),
                      padding: EdgeInsets.all(5.0),
                      height: 170, // Same height as other sections
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: enrolledCourses.length,
                        itemExtent: 200,
                        itemBuilder: (context, index) {
                          String videoId = YoutubePlayer.convertUrlToId(
                              enrolledCourses[index])!;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showCoursePopup(context,
                                      enrolledCourses[index], enrollCourse);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.network(
                                      "https://img.youtube.com/vi/$videoId/maxresdefault.jpg",
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 190,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.error,
                                            color: Colors.red);
                                      },
                                    ),
                                    Icon(
                                      Icons.play_circle_filled,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Web Development Full Course",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0A66C2),
                                ),
                                onPressed: () {
                                  showCoursePopup(context,
                                      enrolledCourses[index], enrollCourse);
                                },
                                child: Text("Watch Now"),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),

              SizedBox(
                height: 20,
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
                    height: 170, // Increased height to fit title and button
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        String? videoId = getYouTubeVideoId(
                            certificationProgramVideos[index]);
                        if (videoId == null)
                          return SizedBox(); // Skip if video ID is invalid

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCoursePopup(
                                    context,
                                    certificationProgramVideos[index],
                                    enrollCourse);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    "https://img.youtube.com/vi/$videoId/maxresdefault.jpg",
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 190,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  ),
                                  Icon(
                                    Icons.play_circle_filled,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Web Development Full Course",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0A66C2),
                              ),
                              onPressed: () {
                                showCoursePopup(
                                    context,
                                    certificationProgramVideos[index],
                                    enrollCourse);
                              },
                              child: Text("Enroll Now"),
                            ),
                          ],
                        );
                      },
                      itemCount: certificationProgramVideos.length,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 200,
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                        height: 170, // Increased height to fit title and button
                        width: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            String? videoId =
                                getYouTubeVideoId(onlineCoursesVideos[index]);
                            if (videoId == null)
                              return SizedBox(); // Skip if video ID is invalid

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showCoursePopup(
                                        context,
                                        onlineCoursesVideos[index],
                                        enrollCourse);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.network(
                                        "https://img.youtube.com/vi/$videoId/maxresdefault.jpg",
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 190,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.error,
                                              color: Colors.red);
                                        },
                                      ),
                                      Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Web Development Full Course",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF0A66C2),
                                  ),
                                  onPressed: () {
                                    showCoursePopup(
                                        context,
                                        onlineCoursesVideos[index],
                                        enrollCourse);
                                  },
                                  child: Text("Enroll Now"),
                                ),
                              ],
                            );
                          },
                          itemCount: onlineCoursesVideos.length,
                          scrollDirection: Axis.horizontal,
                          itemExtent: 200,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
