// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
//
// part 'location_event.dart';
// part 'location_state.dart';
//
// class LocationBloc extends Bloc<LocationEvent, LocationState> {
//   LocationBloc() : super(LocationInitial()) {
//     on<LocationSubmittedEvent>(_getLocationPermission);
//   }
//
//   Future<void> _getLocationPermission(
//       LocationEvent event, Emitter<LocationState> emit) async {
//     print('called');
//
//     bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (isLocationServiceEnabled) {
//       print('location is already enabled');
//     } else {
//       print('location is not enabled');
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         permission = await Geolocator.requestPermission();
//         emit(const LocationDenied('Permission denied'));
//       } else {
//         emit(const LocationGranted('Permission granted'));
//       }
//     }
//   }
// }
