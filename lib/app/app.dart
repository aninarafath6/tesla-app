import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/views/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tesla',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
