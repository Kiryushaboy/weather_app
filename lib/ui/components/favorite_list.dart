import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/hive/favorite_item.dart';
import 'package:weather_app/domain/hive/hive_box.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_bg.dart';
import 'package:weather_app/ui/style/app_colors.dart';
import 'package:weather_app/ui/style/app_style.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable:
            Hive.box<FavoriteItem>(HiveBox.favoriteBox).listenable(),
        builder: (context, Box<FavoriteItem> value, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, i) {
              return FavoriteCard(
                index: i,
                value: value,
              );
            },
            separatorBuilder: (context, i) => const SizedBox(height: 16),
            itemCount: value.length,
          );
        },
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.index,
    required this.value,
  });

  final int index;
  final Box<FavoriteItem> value;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(value.getAt(index)?.bg ?? AppBg.shinyDay),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentFavoriteItems(
            index: index,
            value: value,
          ),
          CurrentWeatherTemp(
            index: index,
            value: value,
          ),
          IconButton(
            onPressed: () {
              model.delete(index);
            },
            icon: Icon(
              Icons.delete,
              size: 25,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentFavoriteItems extends StatelessWidget {
  const CurrentFavoriteItems({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoriteItem> value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Текущее место',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value.getAt(index)?.cityName ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.getAt(index)?.timeZone ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class CurrentWeatherTemp extends StatelessWidget {
  const CurrentWeatherTemp({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoriteItem> value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network('${value.getAt(index)?.icon}'),
        Text('${value.getAt(index)?.temp} °C'),
      ],
    );
  }
}
