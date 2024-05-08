import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/core/widgets/responsive_screen_template.dart';
import 'package:the_geolounge/features/user/presentation/controller/user_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userControllerProvider,
      (previous, current) {
        if (current.isLoading) {
          context.loaderOverlay.show();
        }
        if (current.hasError && (!current.isLoading)) {
          context.loaderOverlay.hide();
          context.snackBar(current.error.toString());
        }
      },
    );
    return Scaffold(
      body: Center(
        child: LoaderOverlay(
          overlayColor: Colors.black26,
          child: ResponsiveScreenTemplate(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  t.user.need_location,
                  textAlign: TextAlign.center,
                  style: context.headlineSmall!.bold,
                ),
                LottieBuilder.asset(
                  Assets.locationAnimation,
                  height: 300,
                ),
                TextButton(
                  onPressed: () async {
                    await ref.read(userControllerProvider.notifier).createUser(
                          getLocationPermission: _getLocationPermission,
                          getLocation: _getLocationPosition,
                          getAddress: _getGeoCode,
                        );
                  },
                  child: Text(t.user.get_location),
                ),
              ],
            ).paddingSymmetric(horizontal: 24),
          ),
        ),
      ),
    );
  }
}

Future<String?> _getLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  'Is Location service enabled $serviceEnabled'.debugLogger();
  if (!serviceEnabled) {
    return 'Location services are disabled, please enable them and try again';
  }
  permission = await Geolocator.requestPermission();

  return switch (permission) {
    LocationPermission.always ||
    LocationPermission.whileInUse ||
    LocationPermission.unableToDetermine =>
      null,
    LocationPermission.denied ||
    LocationPermission.deniedForever =>
      '''Location permissions are denied, can't use the app without location services''',
  };
}

Future<Position> _getLocationPosition() => Geolocator.getCurrentPosition();

Future<Address> _getGeoCode(Position position) async {
  return GeoCode().reverseGeocoding(
    latitude: position.latitude,
    longitude: position.longitude,
  );
}
