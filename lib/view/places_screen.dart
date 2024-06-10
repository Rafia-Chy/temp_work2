import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/app_theme/app_text_styles.dart';

import '../app_theme/app_colors.dart';
import '../bloc/places_bloc.dart';
import '../view_model/places_view_model.dart';
import '../widgets/list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          PlacesViewModel(placesBloc: BlocProvider.of<PlacesBloc>(context)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'explore_routes'.tr(),
            style: AppTextStyles.headerTextStyle,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: Consumer<PlacesViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.places != null) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(child: buildRoutesNearByTitle()),
                ],
                body: ListView(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          (viewModel.places?.data?.nearby?.length ?? 0) > 2
                              ? 2
                              : viewModel.places?.data?.nearby?.length,
                      itemBuilder: (context, index) {
                        final location = viewModel.places!.data!.nearby![index];
                        return RouteNearbyList(location);
                      },
                    ),
                    if ((viewModel.places?.data?.nearby?.length ?? 0) > 2) ...[
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.loadMorePlaces();
                          },
                          child: const Text('Load More'),
                        ),
                      ),
                    ],
                    buildFavToursTitle(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewModel.places?.data?.popular?.length,
                      itemBuilder: (context, index) {
                        final location =
                            viewModel.places!.data!.popular![index];
                        return RouteNearbyList(location);
                      },
                    ),
                  ],
                ),
              );
            } else if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget buildRoutesNearByTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'routes'.tr(),
              style: AppTextStyles.mediumTextStyle,
              children: <TextSpan>[
                TextSpan(
                  text: 'nearby'.tr(),
                  style: AppTextStyles.bodyTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavToursTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'favourite'.tr(),
              style: AppTextStyles.bodyTextStyle,
              children: <TextSpan>[
                TextSpan(
                  text: 'tours'.tr(),
                  style: AppTextStyles.mediumTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
