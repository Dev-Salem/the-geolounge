import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/core/env/env.dart';

part 'supabase_auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.supabase,
  });

  final SupabaseClient supabase;

  Future<void> signInWithGoogle() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await _nativeGoogleSignIn();
    } else {
      await supabase.auth.signInWithOAuth(OAuthProvider.google);
    }
  }

  Future<void> _nativeGoogleSignIn() async {
    final webClientId = Env.webClientId;
    final iosClientId = Env.iosClientId;
    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: kIsWeb ? null : webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw const AuthException('No Access Token found.');
    }
    if (idToken == null) {
      throw const AuthException('No ID Token found.');
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Stream<AuthState> authStateChanges() => supabase.auth.onAuthStateChange;

  Session? get currentSession => supabase.auth.currentSession;

  Future<void> signInAnonymously() => supabase.auth.signInAnonymously();

  Future<void> deleteAccount() async {
    await supabase.functions.invoke('delete_user_account');
  }
}

@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
