import 'package:flutter/material.dart';
import 'package:travel_app/app_theme/app_colors.dart';
import 'package:travel_app/app_theme/app_text_styles.dart';
import 'package:travel_app/model/places_model.dart';
import 'package:travel_app/view_model/places_view_model.dart';

import '../view/detail_screen.dart';

class RouteNearbyList extends StatelessWidget {
  dynamic location;

  RouteNearbyList(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(place: location),
            ),
          );
        },
        child: Container(
          height: 124,
          width: 370,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xffF6F6F6),
                blurRadius: 20.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 0.6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48),
                    child: Image.network(
                      location.coverImage.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name.toString(),
                          style: AppTextStyles.normalTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppIcons.cityIcon,
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    location.location.toString(),
                                    style: AppTextStyles.locationTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.starIconColor,
                                    size: 12,
                                  ),
                                  Text(
                                    '${location.averageRating}/5',
                                    style: AppTextStyles.lightGreyTextStyle,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Divider(
                            color: AppColors.dividerColor,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  AppIcons.clockIcon,
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  formatDuration(
                                    location.duration!,
                                  ),
                                  style: AppTextStyles.locationTextStyle,
                                ),
                                const VerticalDivider(
                                  thickness: 0.8,
                                  width: 20,
                                  color: AppColors.verticalDividerColor,
                                ),
                                Image.asset(
                                  AppIcons.walletIcon,
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '\$${location.price.toString()}',
                                  style: AppTextStyles.locationTextStyle,
                                ),
                                const VerticalDivider(
                                  thickness: 0.8,
                                  width: 20,
                                  color: AppColors.dividerColor,
                                ),
                                Image.asset(
                                  AppIcons.arrowIcon,
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  formatDistance(
                                    location.distance!,
                                  ),
                                  style: AppTextStyles.locationTextStyle,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDuration(int duration) {
    if (duration > 999) {
      double hours = duration / 60;
      return '${hours.toStringAsFixed(1)}h';
    } else {
      return '${duration}m';
    }
  }

  String formatDistance(int distance) {
    if (distance > 999) {
      double kilometers = distance / 1000;
      return '${kilometers.toStringAsFixed(1)}km';
    } else {
      return '${distance}m';
    }
  }
}
