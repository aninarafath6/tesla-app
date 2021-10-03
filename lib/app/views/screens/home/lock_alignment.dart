import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';

import 'door_lock.dart';

class LockAlignment extends StatelessWidget {
  const LockAlignment({
    Key? key,
    required this.constraints,
    this.child,
    this.door,
    this.isLocked,
    this.align,
  }) : super(key: key);

  final BoxConstraints? constraints;
  final DoorLock? child;
  final Lock? door;
  final bool? isLocked;
  final Alignment? align;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppSizes.defaultDuration,
      right: align == Alignment.centerRight
          ? context.watch<HomeProvider>().selectedNav == 0
              ? constraints!.maxWidth * .03
              : constraints!.maxWidth / 2
          : null,
      left: align == Alignment.centerLeft
          ? context.watch<HomeProvider>().selectedNav == 0
              ? constraints!.maxWidth * .03
              : constraints!.maxWidth / 2
          : null,
      top: align == Alignment.topCenter
          ? context.watch<HomeProvider>().selectedNav == 0
              ? constraints!.maxHeight * .13
              : constraints!.maxWidth / 2
          : null,
      bottom: align == Alignment.bottomCenter
          ? context.watch<HomeProvider>().selectedNav == 0
              ? constraints!.maxHeight * .17
              : constraints!.maxWidth / 2
          : null,
      child: AnimatedOpacity(
        opacity: context.watch<HomeProvider>().selectedNav == 0 ? 1 : 0,
        duration: AppSizes.defaultDuration,
        child: DoorLock(
          door: door,
          isLocked: isLocked,
        ),
      ),
    );
  }
}
