// lib/cubit/nearby_place_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:via/repositories/wiki_repository.dart';

import 'nearby_places_state.dart';

class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  final WikiRepository repository = WikiRepository();

  NearbyPlaceCubit() : super(NearbyPlaceInitial());

  Future<void> fetchNearbyPlaces(double lat, double lon) async {
    emit(NearbyPlaceLoading());
    try {
      final data = await repository.fetchNearbyPlaces(lat, lon);
      emit(NearbyPlaceLoaded(data));
    } catch (e) {
      emit(NearbyPlaceError(e.toString()));
    }
  }
}
