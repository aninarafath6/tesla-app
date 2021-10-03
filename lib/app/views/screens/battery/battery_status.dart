import 'package:flutter/material.dart';
import 'package:tesla/app/constants/app_sizes.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({Key? key, this.constraints}) : super(key: key);
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '420 mi',
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Colors.white,
              ),
        ),
        SizedBox(
          height: constraints!.maxHeight * .06,
        ),
        Text(
          '40%',
          style: Theme.of(context).textTheme.headline5,
        ),
        const Spacer(),
        const Text(
          'CHARGING',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const Text(
          '22 min remainging',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        SizedBox(height: constraints!.maxHeight * .16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defualtPadding,
            vertical: AppSizes.defualtPadding,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '33 mi/hr',
                ),
                Text('232v'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
