import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';
import 'package:tesla/app/utils/enums.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({Key? key, this.isLocked, this.door}) : super(key: key);

  final bool? isLocked;
  final Lock? door;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<HomeProvider>().updateLock(door!);
      },
      child: AnimatedSwitcher(
        duration: AppSizes.defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: isLocked!
            ? SvgPicture.asset(
                AppImages.unlock,
                key: const ValueKey('unlcok'),
              )
            : SvgPicture.asset(
                AppImages.lock,
                key: const ValueKey('lock'),
              ),
      ),
    );
  }
}
