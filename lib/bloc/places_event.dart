import 'package:equatable/equatable.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaces extends PlacesEvent {}

class LoadMorePlaces extends PlacesEvent {}
