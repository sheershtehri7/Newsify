import 'package:api_project_1/main.dart';
import 'package:api_project_1/pages/bycountry.dart';
import 'package:api_project_1/pages/categories.dart';
import 'package:api_project_1/pages/mainpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class mainpage extends StatefulWidget {
  final String author, title, image, source, content, urll, time, fromPage;
  const mainpage(
      {super.key,
      required this.author,
      required this.title,
      required this.time,
      required this.content,
      required this.image,
      required this.source,
      required this.fromPage,
      required this.urll});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  final format = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 226, 191, 191),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 226, 191, 191),
            leading: IconButton(
                onPressed: () {
                  if (widget.fromPage == 'Page') {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => CountryPage()));
                  } else if (widget.fromPage == 'Page') {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => categoriesby()));
                  }
                },
                icon: Icon(CupertinoIcons.back))
            //Icon(CupertinoIcons.back),

            ),
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF475269),
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(15),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.5,
                  imageUrl: widget.image ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SpinKitCircle(
                    size: 50,
                    color: Colors.blue,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 191, 191),
                    borderRadius: BorderRadius.circular(30)),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.title + '.',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.source,
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 185, 2, 2),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.time,
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 185, 2, 2),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.content,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            TextSpan(
                              text: ' Read More',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 157, 188),
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  dynamic url = widget.urll;
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
