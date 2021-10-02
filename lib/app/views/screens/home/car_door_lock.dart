
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/views/screens/home/door_lock.dart';

class CarDoorLock extends StatelessWidget {
  const CarDoorLock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: constrains.maxHeight * .1,
            ),
            child: SvgPicture.asset(
              AppImages.teslaCar,
              width: double.infinity,
            ),
          ),
          Positioned(
            right: constrains.maxWidth * .03,
            child: DoorLock(
              door: Lock.rightDoorLcok,
              isLocked: provider.rightLock,
            ),
          ),
          Positioned(
            left: constrains.maxWidth * .03,
            child: DoorLock(
              door: Lock.leftDoorLock,
              isLocked: provider.leftLock,
            ),
          ),
          Positioned(
            top: constrains.maxHeight * .13,
            child: DoorLock(
              door: Lock.bonnetLock,
              isLocked: provider.bonetLock,
            ),
          ),
          Positioned(
            bottom: constrains.maxHeight * .17,
            child: DoorLock(
              door: Lock.trunkLook,
              isLocked: provider.trunkLock,
            ),
          ),
        ],
      );
    });
  }
}
