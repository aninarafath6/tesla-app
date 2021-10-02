import 'package:flutter/material.dart';
import 'package:tesla/app/views/screens/home/bottom_nav.dart';
import 'package:tesla/app/views/screens/home/car_door_lock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        selectedTab: 0,
        onTap: (value) {},
      ),
      body: const SafeArea(
        child: CarDoorLock(),
      ),
    );
  }
}
