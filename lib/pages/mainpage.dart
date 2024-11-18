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

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum FilterList { ABCNews, BBCNews, BusinessInsider, CNN, ESPN }

class _HomepageState extends State<Homepage> {
  FilterList? selectedMenu;
  late Future<List> news;
  Future<List> fetchnews(String channelName) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=01db01fcf399436584c59ab31c5231cd'));
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

  String name = 'bbc-news';
  String NewsChannelPage = 'newspage';

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
                if (item == FilterList.BBCNews) {
                  name = 'abc-news';
                }
                if (item == FilterList.ABCNews) {
                  name = 'bbc-news';
                }
                if (item == FilterList.BusinessInsider) {
                  name = 'business-insider';
                }
                if (item == FilterList.ESPN) {
                  name = 'espn';
                }
                if (item == FilterList.CNN) {
                  name = 'cnn';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    PopupMenuItem(
                      value: FilterList.CNN,
                      child: Text('CNN'),
                    ),
                    PopupMenuItem(
                      child: Text('BBC News'),
                      value: FilterList.BBCNews,
                    ),
                    PopupMenuItem(
                      child: Text('ESPN'),
                      value: FilterList.ESPN,
                    ),
                    PopupMenuItem(
                      child: Text('Business Insider'),
                      value: FilterList.BusinessInsider,
                    ),
                    PopupMenuItem(
                      child: Text('ABC News'),
                      value: FilterList.ABCNews,
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
                                          scrollDirection: Axis.vertical,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          mainpage(
                                                              fromPage:
                                                                  NewsChannelPage,
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
                                                        Text(
                                                          snapshot.data![index]
                                                                  ['source']
                                                              ['name'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
