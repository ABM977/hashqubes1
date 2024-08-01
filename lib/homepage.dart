
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List banner = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  int totalPages = 10; // Set this to the total number of pages you expect

  Future<void> bannerdata(int page) async {
    setState(() {
      isLoading = true;
    });
    String apiUrl =
        "https://jsonplaceholder.typicode.com/posts?_page=$page"; // Add page parameter
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        setState(() {
          banner = jsonData; // Update to replace the list for simplicity
          isLoading = false;
        });
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    bannerdata(page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !isLoading) {
        if (page < totalPages) {
          setState(() {
            page++;
          });
          bannerdata(page);
        }
      }
    });
  }

  void _onPageSelected(int newPage) {
    setState(() {
      page = newPage;
    });
    bannerdata(page);
    // Scroll to the top
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcfd4cf),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              height: 70,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "HashQubes",
                    style: GoogleFonts.signikaNegative(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff244a3f),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast),
                    itemCount: banner.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < banner.length) {
                        return Card(
                          color: Color(0xff427869),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              banner[index]["title"],
                              style: GoogleFonts.signikaNegative(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            //
                            subtitle: Text(
                              banner[index]["body"],
                              style: GoogleFonts.signika(
                                color: Colors.white54,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }
                      // else {
                      //   // Ensure that a widget is always returned
                      //   return Center(
                      //     child: isLoading
                      //         ? CircularProgressIndicator(
                      //       semanticsLabel: "Loading",
                      //     )
                      //         : SizedBox.shrink(), // Return an empty box if not loading
                      //   );
                      // }
                    },
                  ),
                  if (isLoading)
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Center(
                        child:CircularProgressIndicator (
                          color: Colors.white,
                          semanticsLabel: "Loading",
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPaginator(),
                  ],)),],),),);
  }
  Widget _buildPaginator() {
    if (totalPages <= 0) {
      return SizedBox.shrink(); // Return an empty box if no pages
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final pageNumber = index + 1;
          return GestureDetector(
            onTap: () => _onPageSelected(pageNumber),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: page == pageNumber ? Color(0xff244a3f) : Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  '$pageNumber',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),),),);}),),);}}
