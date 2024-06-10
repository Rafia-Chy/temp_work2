import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bloc/places_event.dart';
import 'package:travel_app/bloc/places_state.dart';

import '../repository/repository.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesRepository repository;

  PlacesBloc({required this.repository}) : super(PlacesInitial()) {
    on<FetchPlaces>(_onFetchPlaces);
    on<LoadMorePlaces>(_loadMorePlaces);
  }

  void _onFetchPlaces(FetchPlaces event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      final places = await repository.fetchLocations();
      emit(PlacesLoaded(places));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }

  void _loadMorePlaces(LoadMorePlaces event, Emitter<PlacesState> emit) async {
    final currentState = state;

    if (currentState is PlacesLoaded) {
      try {
        final places = await repository.fetchLocations();
        final allPlaces = currentState.places;

        emit(PlacesLoaded(allPlaces));
      } catch (e) {
        emit(PlacesError(e.toString()));
      }
    }
  }
}
