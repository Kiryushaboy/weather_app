import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_icons.dart';
import 'package:weather_app/ui/style/app_colors.dart';
import 'package:weather_app/ui/style/app_style.dart';

class DayPositionItem extends StatelessWidget {
  const DayPositionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RowItem(
            icon: AppIcons.sunrise,
            text: 'Восход ${model.setSunRise()}',
          ),
          RowItem(
            icon: AppIcons.sunset,
            text: 'Закат ${model.setSunSet()}',
          ),
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final String text, icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          // ignore: deprecated_member_use
          color: AppColors.black,
        ),
        const SizedBox(height: 18),
        Text(
          text,
          style: AppStyle.fontStyle.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
