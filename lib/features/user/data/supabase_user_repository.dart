import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/core/constants/schema.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/data/supabase_auth_repository.dart';
import 'package:the_geolounge/features/user/domain/user_entity.dart' as entity;
part 'supabase_user_repository.g.dart';

class UserRepository {
  UserRepository({required this.supabase, required this.prefs});
  final SharedPreferences prefs;
  final SupabaseClient supabase;

  Future<void> createUser(String country, String city) async {
    final user = entity.User(
      country: country,
      city: city,
      email: supabase.auth.currentUser!.email,
    );
    await supabase.from(SupabaseConstants.user).upsert(
          user.toMap(),
          onConflict: 'id',
        );
  }

  Future<entity.User> getCurrentUser() async {
    final user = supabase
        .from(SupabaseConstants.user)
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .withConverter((data) => data.map(entity.User.fromMap).toList().first);
    return user;
  }

  Future<void> clearLocalStorage() => prefs.clear();

  bool get isFirstSignIn => prefs.getBool('isFirstSignIn') ?? true;

  Future<void> setIsFirstSignIn({required bool value}) async {
    await prefs.setBool('isFirstSignIn', value);
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(
    supabase: ref.watch(supabaseClientProvider),
    prefs: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@Riverpod(keepAlive: true)
FutureOr<entity.User> currentUser(CurrentUserRef ref) {
  return ref.watch(userRepositoryProvider).getCurrentUser();
}

@Riverpod(keepAlive: true)
FutureOr<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  throw UnimplementedError();
}
