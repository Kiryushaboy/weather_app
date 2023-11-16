import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/current_region_item.dart';
import 'package:weather_app/ui/components/favorite_list.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/style/app_colors.dart';
import 'package:weather_app/ui/style/app_style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: 26,
          ),
        ),
        title: SizedBox(
          width: 312,
          height: 35,
          child: TextField(
            controller: model.searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              fillColor: AppColors.inputColor,
              filled: true,
              hintText: 'Введите город/регион',
              hintStyle: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                color: AppColors.black.withOpacity(0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
            ),
            cursorColor: AppColors.black.withOpacity(0.5),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.setCurrentCity(context);
            },
            icon: Icon(
              Icons.search,
              size: 34,
              color: AppColors.black,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SearchBody(model: model),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key, required this.model});

  final WeatherProvider model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            model.setBg(),
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurrentRegionItem(),
          const SizedBox(height: 24),
          Text(
            'Избранное',
            style: AppStyle.fontStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const FavoriteList(),
        ],
      ),
    );
  }
}
