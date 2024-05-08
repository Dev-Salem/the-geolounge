// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_post_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postRepositoryHash() => r'bcc8c3adffc40a6740329ac2a9c96e1a7e15ab75';

/// See also [postRepository].
@ProviderFor(postRepository)
final postRepositoryProvider = Provider<PostRepository>.internal(
  postRepository,
  name: r'postRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PostRepositoryRef = ProviderRef<PostRepository>;
String _$getPostDetailsHash() => r'02b42fab407f1b40804760779ef61a3045f494f7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getPostDetails].
@ProviderFor(getPostDetails)
const getPostDetailsProvider = GetPostDetailsFamily();

/// See also [getPostDetails].
class GetPostDetailsFamily extends Family<AsyncValue<Post>> {
  /// See also [getPostDetails].
  const GetPostDetailsFamily();

  /// See also [getPostDetails].
  GetPostDetailsProvider call(
    String postId,
  ) {
    return GetPostDetailsProvider(
      postId,
    );
  }

  @override
  GetPostDetailsProvider getProviderOverride(
    covariant GetPostDetailsProvider provider,
  ) {
    return call(
      provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPostDetailsProvider';
}

/// See also [getPostDetails].
class GetPostDetailsProvider extends AutoDisposeStreamProvider<Post> {
  /// See also [getPostDetails].
  GetPostDetailsProvider(
    String postId,
  ) : this._internal(
          (ref) => getPostDetails(
            ref as GetPostDetailsRef,
            postId,
          ),
          from: getPostDetailsProvider,
          name: r'getPostDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostDetailsHash,
          dependencies: GetPostDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetPostDetailsFamily._allTransitiveDependencies,
          postId: postId,
        );

  GetPostDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Override overrideWith(
    Stream<Post> Function(GetPostDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPostDetailsProvider._internal(
        (ref) => create(ref as GetPostDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Post> createElement() {
    return _GetPostDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostDetailsProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPostDetailsRef on AutoDisposeStreamProviderRef<Post> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _GetPostDetailsProviderElement
    extends AutoDisposeStreamProviderElement<Post> with GetPostDetailsRef {
  _GetPostDetailsProviderElement(super.provider);

  @override
  String get postId => (origin as GetPostDetailsProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
