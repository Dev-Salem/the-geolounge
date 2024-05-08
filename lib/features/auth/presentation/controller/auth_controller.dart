import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/features/auth/data/supabase_auth_repository.dart';
import 'package:the_geolounge/features/user/user.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}
  Future<void> signInWithGoogle() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInWithGoogle);
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<void> signOut() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await authRepository.signOut();
      await ref.watch(userRepositoryProvider).clearLocalStorage();
    });
  }

  Future<void> deleteAccount() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.deleteAccount);
    await signOut();
  }
}
