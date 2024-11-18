import 'dart:convert';
import 'package:api_project_1/pages/CategoryPage.dart';
import 'package:api_project_1/pages/mainworkpage.dart';
import 'package:api_project_1/pages/splashscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class categoriesby extends StatefulWidget {
  const categoriesby({super.key});

  @override
  State<categoriesby> createState() => _categoriesbyState();
}

enum FilterList {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}

class _categoriesbyState extends State<categoriesby> {
  FilterList? selectedMenu;
  late Future<List> news;
  Future<List> fetchnews(String categoryName) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=${categoryName}&apiKey=01db01fcf399436584c59ab31c5231cd'));
    Map result = jsonDecode(response.body);
    print('Fetched');

    return (result['articles']);
  }

  @override
  void initState() {
    super.initState();
    news = fetchnews(name);
  }

  final format = DateFormat('MMM dd, yyyy');

  String name = 'science';
  String CategoryPage = 'categorypage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 191, 191),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Categorypage()));
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 185, 2, 2),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton(
              initialValue: selectedMenu,
              iconColor: const Color.fromARGB(255, 255, 255, 255),
              onSelected: (FilterList item) {
                if (item == FilterList.business) {
                  name = 'business';
                }
                if (item == FilterList.science) {
                  name = 'science';
                }
                if (item == FilterList.entertainment) {
                  name = 'entertainment';
                }
                if (item == FilterList.general) {
                  name = 'general';
                }
                if (item == FilterList.health) {
                  name = 'health';
                }
                if (item == FilterList.sports) {
                  name = 'sports';
                }
                if (item == FilterList.technology) {
                  name = 'technology';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    PopupMenuItem(
                      value: FilterList.business,
                      child: Text('Business'),
                    ),
                    PopupMenuItem(
                      child: Text('Entertainment'),
                      value: FilterList.entertainment,
                    ),
                    PopupMenuItem(
                      child: Text('General'),
                      value: FilterList.general,
                    ),
                    PopupMenuItem(
                      child: Text('Health'),
                      value: FilterList.health,
                    ),
                    PopupMenuItem(
                      child: Text('Science'),
                      value: FilterList.science,
                    ),
                    PopupMenuItem(
                      child: Text('Sports'),
                      value: FilterList.sports,
                    ),
                    PopupMenuItem(
                      child: Text('Technology'),
                      value: FilterList.technology,
                    )
                  ])
        ],
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/7.jpg',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        SafeArea(
            child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: fetchnews(name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return Center(child: Text("No data available"));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                            snapshot.data![index]['publishedAt']);

                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.9,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data![index]
                                                    ['urlToImage'] ??
                                                'https://via.placeholder.com/150',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                SpinKitCircle(
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: SingleChildScrollView(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          mainpage(
                                                              fromPage:
                                                                  CategoryPage,
                                                              time: format.format(
                                                                  dateTime),
                                                              author: 'sid',
                                                              // author: snapshot
                                                              //         .data![index]
                                                              //     ['author'],
                                                              title: snapshot
                                                                      .data![index]
                                                                  ['title'],
                                                              content: snapshot
                                                                      .data![index][
                                                                  'description'],
                                                              image: snapshot
                                                                      .data![index][
                                                                  'urlToImage'],
                                                              source: snapshot
                                                                          .data![index]
                                                                      ['source']
                                                                  ['name'],
                                                              urll: snapshot
                                                                      .data![index]
                                                                  ['url'])));
                                            },
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFF475269),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                    )
                                                  ],
                                                ),
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      child: Text(
                                                        snapshot.data![index]
                                                                ['title'] +
                                                            '.',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            snapshot.data![
                                                                        index]
                                                                    ['source']
                                                                ['name'],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Text(
                                                          format
                                                              .format(dateTime),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        )),
      ]),
    );
  }
}
