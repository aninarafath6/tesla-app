import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/views/screens/home/bottom_nav.dart';
import 'package:tesla/app/views/screens/home/car_door_lock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        selectedTab: context.watch<HomeProvider>().selectedNav,
        onTap: context.read<HomeProvider>().onChangeBottomNav,
      ),
      body: const SafeArea(
        child: CarDoorLock(),
      ),
    );
  }
}
