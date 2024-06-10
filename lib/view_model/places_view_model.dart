import 'package:flutter/material.dart';

import '../bloc/places_bloc.dart';
import '../bloc/places_event.dart';
import '../bloc/places_state.dart';
import '../model/places_model.dart';

class PlacesViewModel with ChangeNotifier {
  PlacesModel? places;
  bool isLoading = false;
  bool isLoadingMore = false;
  String? error;
  final PlacesBloc placesBloc;
  List<Nearby>? nearByPlaces = [];
  int currentPage = 1;
  bool hasMore = true; // Tracks if there are more places to load

  PlacesViewModel({required this.placesBloc}) {
    fetchPlaces();
    placesBloc.stream.listen((state) {
      if (state is PlacesLoading) {
        isLoading = true;
        error = null;
        notifyListeners();
      } else if (state is PlacesLoaded) {
        places = state.places;
        isLoading = false;
        error = null;
        notifyListeners();
      } else if (state is PlacesError) {
        error = state.message;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void fetchPlaces() {
    placesBloc.add(FetchPlaces());
  }

  void loadMorePlaces() {
    if (hasMore && !isLoadingMore) {
      placesBloc.add(LoadMorePlaces());
    }
  }
}
