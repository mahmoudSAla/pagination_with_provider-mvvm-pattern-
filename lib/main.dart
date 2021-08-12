
import 'package:flutter/material.dart';
import 'package:pagination_with_provider/provider/news_provider.dart';
import 'package:pagination_with_provider/view/home_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
          child: HomePage(),
        ),
      ],
      child: MaterialApp(
        title: 'Infinite Scrolling',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}