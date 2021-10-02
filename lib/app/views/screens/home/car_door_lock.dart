import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
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
          AnimatedPositioned(
            duration: AppSizes.defualtDuration,
            right: context.watch<HomeProvider>().selectedNav == 0
                ? constrains.maxWidth * .03
                : constrains.maxWidth / 2,
            child: AnimatedOpacity(
              opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 : 0,
              duration: AppSizes.defualtDuration,
              child: DoorLock(
                door: Lock.rightDoorLcok,
                isLocked: provider.rightLock,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: AppSizes.defualtDuration,
            left: context.watch<HomeProvider>().selectedNav == 0
                ? constrains.maxWidth * .03
                : constrains.maxWidth / 2,
            child: AnimatedOpacity(
              opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 : 0,
              duration: AppSizes.defualtDuration,
              child: DoorLock(
                door: Lock.leftDoorLock,
                isLocked: provider.leftLock,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: AppSizes.defualtDuration,
            top: context.watch<HomeProvider>().selectedNav == 0
                ? constrains.maxHeight * .13
                : constrains.maxHeight / 2,
            child: AnimatedOpacity(
              opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 : 0,
              duration: AppSizes.defualtDuration,
              child: DoorLock(
                door: Lock.bonnetLock,
                isLocked: provider.bonetLock,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: AppSizes.defualtDuration,
            bottom: context.watch<HomeProvider>().selectedNav == 0
                ? constrains.maxHeight * .17
                : constrains.maxHeight / 2,
            child: AnimatedOpacity(
              opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 : 0,
              duration: AppSizes.defualtDuration,
              child: DoorLock(
                door: Lock.trunkLook,
                isLocked: provider.trunkLock,
              ),
            ),
          ),
        ],
      );
    });
  }
}
