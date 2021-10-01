import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:tesla/app/constants/app_images.dart';
import 'package:tesla/app/constants/app_sizes.dart';
import 'package:tesla/app/provider/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constrains) {
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
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeProvider>().updateLock(Lock.rightDoorLcok);
                  },
                  child: AnimatedSwitcher(
                    duration: AppSizes.defualtDuration,
                    switchInCurve: Curves.easeInOutBack,
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: context.watch<HomeProvider>().rightLock
                        ? SvgPicture.asset(
                            AppImages.lock,
                            key: const ValueKey('lock'),
                          )
                        : SvgPicture.asset(
                            AppImages.unlock,
                            key: const ValueKey('unlock'),
                          ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
