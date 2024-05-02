import 'package:equatable/equatable.dart';
import 'package:via/models/wiki_page.dart';

abstract class NearbyPlaceState extends Equatable {
  @override
  List<WikiPage> get props => [];
}

class NearbyPlaceInitial extends NearbyPlaceState {}

class NearbyPlaceLoading extends NearbyPlaceState {}

class NearbyPlaceLoaded extends NearbyPlaceState {
  final List<WikiPage> data;
  NearbyPlaceLoaded(this.data);

  List<WikiPage> get props => data;
}

class NearbyPlaceError extends NearbyPlaceState {
  final String message;
  NearbyPlaceError(this.message);

  @override
  List<WikiPage> get props => [];
}
