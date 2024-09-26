import 'package:foodfixer/core/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


@injectable
class GeoLocationCubit extends AppBaseCubit<GeoLocationState> {
  GeoLocationCubit() : super(GeoLocationState.initial());

  void fetchLocation() async {
    emitSafeState(GeoLocationState.initial().copyWith(isLoading: true));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      emitSafeState(state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: 'Location permission denied'));
      return;
    }
    if (permission == LocationPermission.deniedForever) {
      emitSafeState(state.copyWith(
          isLoading: false,
          isSuccess: false,
          error:
              'Location permission denied forever , Please enable location from settings '));
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      emitSafeState(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          hasPermission: true,
          placemark: placemarks.first,
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      emitSafeState(state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: 'Error getting Location : $e'));
    }
  }
}

@freezed
class GeoLocationState with _$GeoLocationState {
  const factory GeoLocationState({
    required bool isLoading,
    required bool isSuccess,
    String? error,
    required bool hasPermission,
    Placemark? placemark,
    double? latitude,
    double? longitude,
  }) = _GeoLocationState;

  factory GeoLocationState.initial() => const GeoLocationState(
        hasPermission: false,
        isLoading: false,
        isSuccess: false,
      );
}