import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_icons.dart';
import 'package:weather_app/ui/style/app_colors.dart';
import 'package:weather_app/ui/style/app_style.dart';

class TempratureItems extends StatelessWidget {
  const TempratureItems({super.key});

  @override
  Widget build(BuildContext context) {
    final tempItem = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcons.maxTemp,
          color: AppColors.red,
        ),
        const SizedBox(width: 4),
        Text(
          '${tempItem.maxTemp}°',
          style: AppStyle.fontStyle.copyWith(fontSize: 25),
        ),
        const SizedBox(width: 65),
        SvgPicture.asset(
          AppIcons.minTemp,
          color: AppColors.blue,
        ),
        const SizedBox(width: 4),
        Text(
          '${tempItem.minTemp}°',
          style: AppStyle.fontStyle.copyWith(fontSize: 25),
        ),
      ],
    );
  }
}
