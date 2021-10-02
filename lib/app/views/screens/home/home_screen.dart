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
        onTap: (index) {
          if (index == 1) {
            context.read<HomeProvider>().animationController.forward();
          } else if (context.read<HomeProvider>().selectedNav == 1 &&
              index != 1) {
            context.read<HomeProvider>().animationController.reverse(from: .7);
          }
          context.read<HomeProvider>().onChangeBottomNav(index);
        },
        selectedTab: context.watch<HomeProvider>().selectedNav,
      ),
      body: const SafeArea(
        child: CarDoorLock(),
      ),
    );
  }
}
