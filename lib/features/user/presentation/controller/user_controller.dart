import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/user/data/supabase_user_repository.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  FutureOr<void> build() {}
  Future<void> createUser({
    required Future<String?> Function() getLocationPermission,
    required Future<Position> Function() getLocation,
    required Future<Address> Function(Position position) getAddress,
  }) async {
    state = const AsyncLoading();
    final permissionErrorMessage = await getLocationPermission();
    if (permissionErrorMessage != null) {
      state = AsyncValue.error(permissionErrorMessage, StackTrace.current);
    } else {
      final position = await getLocation();
      final address = await getAddress(position);
      'Position $position, $address'.debugLogger();
      if (address.countryName == null || address.city == null) {
        state = AsyncValue.error(
          "Couldn't get your address, please try again",
          StackTrace.current,
        );
      } else {
        final userRepository = ref.watch(userRepositoryProvider);
        state = await AsyncValue.guard(
          () => userRepository.createUser(address.countryName!, address.city!),
        );
        'State: $state'.infoLogger();
        if (state.hasValue) {
          await userRepository.setIsFirstSignIn(value: false);
          ref.watch(goRouterProvider).go(Routes.chat);
        }
      }
    }
  }
}
