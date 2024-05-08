// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'0f2654c563501cc369582eb1b3edbeafbb46b965';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = Provider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatRepositoryRef = ProviderRef<ChatRepository>;
String _$getMessagesHash() => r'25ad9cde190ca4a6085a0f69996d8e2009898c7b';

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

/// See also [getMessages].
@ProviderFor(getMessages)
const getMessagesProvider = GetMessagesFamily();

/// See also [getMessages].
class GetMessagesFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [getMessages].
  const GetMessagesFamily();

  /// See also [getMessages].
  GetMessagesProvider call(
    String requestId,
  ) {
    return GetMessagesProvider(
      requestId,
    );
  }

  @override
  GetMessagesProvider getProviderOverride(
    covariant GetMessagesProvider provider,
  ) {
    return call(
      provider.requestId,
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
  String? get name => r'getMessagesProvider';
}

/// See also [getMessages].
class GetMessagesProvider extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [getMessages].
  GetMessagesProvider(
    String requestId,
  ) : this._internal(
          (ref) => getMessages(
            ref as GetMessagesRef,
            requestId,
          ),
          from: getMessagesProvider,
          name: r'getMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMessagesHash,
          dependencies: GetMessagesFamily._dependencies,
          allTransitiveDependencies:
              GetMessagesFamily._allTransitiveDependencies,
          requestId: requestId,
        );

  GetMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestId,
  }) : super.internal();

  final String requestId;

  @override
  Override overrideWith(
    Stream<List<Message>> Function(GetMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMessagesProvider._internal(
        (ref) => create(ref as GetMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestId: requestId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _GetMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMessagesProvider && other.requestId == requestId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMessagesRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `requestId` of this provider.
  String get requestId;
}

class _GetMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with GetMessagesRef {
  _GetMessagesProviderElement(super.provider);

  @override
  String get requestId => (origin as GetMessagesProvider).requestId;
}

String _$getChatRequestsHash() => r'e757a98c0f2f3c4f5dd8c1078ed6e73be3f688a4';

/// See also [getChatRequests].
@ProviderFor(getChatRequests)
const getChatRequestsProvider = GetChatRequestsFamily();

/// See also [getChatRequests].
class GetChatRequestsFamily extends Family<AsyncValue<List<ChatRequest>>> {
  /// See also [getChatRequests].
  const GetChatRequestsFamily();

  /// See also [getChatRequests].
  GetChatRequestsProvider call(
    RequestStatus requestStatus,
  ) {
    return GetChatRequestsProvider(
      requestStatus,
    );
  }

  @override
  GetChatRequestsProvider getProviderOverride(
    covariant GetChatRequestsProvider provider,
  ) {
    return call(
      provider.requestStatus,
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
  String? get name => r'getChatRequestsProvider';
}

/// See also [getChatRequests].
class GetChatRequestsProvider
    extends AutoDisposeStreamProvider<List<ChatRequest>> {
  /// See also [getChatRequests].
  GetChatRequestsProvider(
    RequestStatus requestStatus,
  ) : this._internal(
          (ref) => getChatRequests(
            ref as GetChatRequestsRef,
            requestStatus,
          ),
          from: getChatRequestsProvider,
          name: r'getChatRequestsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChatRequestsHash,
          dependencies: GetChatRequestsFamily._dependencies,
          allTransitiveDependencies:
              GetChatRequestsFamily._allTransitiveDependencies,
          requestStatus: requestStatus,
        );

  GetChatRequestsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestStatus,
  }) : super.internal();

  final RequestStatus requestStatus;

  @override
  Override overrideWith(
    Stream<List<ChatRequest>> Function(GetChatRequestsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChatRequestsProvider._internal(
        (ref) => create(ref as GetChatRequestsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestStatus: requestStatus,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ChatRequest>> createElement() {
    return _GetChatRequestsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChatRequestsProvider &&
        other.requestStatus == requestStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChatRequestsRef on AutoDisposeStreamProviderRef<List<ChatRequest>> {
  /// The parameter `requestStatus` of this provider.
  RequestStatus get requestStatus;
}

class _GetChatRequestsProviderElement
    extends AutoDisposeStreamProviderElement<List<ChatRequest>>
    with GetChatRequestsRef {
  _GetChatRequestsProviderElement(super.provider);

  @override
  RequestStatus get requestStatus =>
      (origin as GetChatRequestsProvider).requestStatus;
}

String _$getAcceptedChatRequestsHash() =>
    r'14b8062f5fcae0129b78e27ec49cdd0395472c61';

/// See also [getAcceptedChatRequests].
@ProviderFor(getAcceptedChatRequests)
final getAcceptedChatRequestsProvider =
    AutoDisposeStreamProvider<List<ChatRequest>>.internal(
  getAcceptedChatRequests,
  name: r'getAcceptedChatRequestsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAcceptedChatRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAcceptedChatRequestsRef
    = AutoDisposeStreamProviderRef<List<ChatRequest>>;
String _$getChatMessagesHash() => r'0306f787636b458aa8348ec5b28a7f0af2be5e62';

/// See also [getChatMessages].
@ProviderFor(getChatMessages)
const getChatMessagesProvider = GetChatMessagesFamily();

/// See also [getChatMessages].
class GetChatMessagesFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [getChatMessages].
  const GetChatMessagesFamily();

  /// See also [getChatMessages].
  GetChatMessagesProvider call(
    String chatRequestId,
  ) {
    return GetChatMessagesProvider(
      chatRequestId,
    );
  }

  @override
  GetChatMessagesProvider getProviderOverride(
    covariant GetChatMessagesProvider provider,
  ) {
    return call(
      provider.chatRequestId,
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
  String? get name => r'getChatMessagesProvider';
}

/// See also [getChatMessages].
class GetChatMessagesProvider extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [getChatMessages].
  GetChatMessagesProvider(
    String chatRequestId,
  ) : this._internal(
          (ref) => getChatMessages(
            ref as GetChatMessagesRef,
            chatRequestId,
          ),
          from: getChatMessagesProvider,
          name: r'getChatMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChatMessagesHash,
          dependencies: GetChatMessagesFamily._dependencies,
          allTransitiveDependencies:
              GetChatMessagesFamily._allTransitiveDependencies,
          chatRequestId: chatRequestId,
        );

  GetChatMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRequestId,
  }) : super.internal();

  final String chatRequestId;

  @override
  Override overrideWith(
    Stream<List<Message>> Function(GetChatMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChatMessagesProvider._internal(
        (ref) => create(ref as GetChatMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRequestId: chatRequestId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _GetChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChatMessagesProvider &&
        other.chatRequestId == chatRequestId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRequestId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChatMessagesRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `chatRequestId` of this provider.
  String get chatRequestId;
}

class _GetChatMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with GetChatMessagesRef {
  _GetChatMessagesProviderElement(super.provider);

  @override
  String get chatRequestId => (origin as GetChatMessagesProvider).chatRequestId;
}

String _$getLastMessageHash() => r'c6c00e05e2143610869d6d847f85ccd2baa70bc2';

/// See also [getLastMessage].
@ProviderFor(getLastMessage)
const getLastMessageProvider = GetLastMessageFamily();

/// See also [getLastMessage].
class GetLastMessageFamily extends Family<AsyncValue<Message>> {
  /// See also [getLastMessage].
  const GetLastMessageFamily();

  /// See also [getLastMessage].
  GetLastMessageProvider call(
    String chatId,
  ) {
    return GetLastMessageProvider(
      chatId,
    );
  }

  @override
  GetLastMessageProvider getProviderOverride(
    covariant GetLastMessageProvider provider,
  ) {
    return call(
      provider.chatId,
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
  String? get name => r'getLastMessageProvider';
}

/// See also [getLastMessage].
class GetLastMessageProvider extends AutoDisposeStreamProvider<Message> {
  /// See also [getLastMessage].
  GetLastMessageProvider(
    String chatId,
  ) : this._internal(
          (ref) => getLastMessage(
            ref as GetLastMessageRef,
            chatId,
          ),
          from: getLastMessageProvider,
          name: r'getLastMessageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLastMessageHash,
          dependencies: GetLastMessageFamily._dependencies,
          allTransitiveDependencies:
              GetLastMessageFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  GetLastMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Override overrideWith(
    Stream<Message> Function(GetLastMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetLastMessageProvider._internal(
        (ref) => create(ref as GetLastMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Message> createElement() {
    return _GetLastMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLastMessageProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetLastMessageRef on AutoDisposeStreamProviderRef<Message> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _GetLastMessageProviderElement
    extends AutoDisposeStreamProviderElement<Message> with GetLastMessageRef {
  _GetLastMessageProviderElement(super.provider);

  @override
  String get chatId => (origin as GetLastMessageProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
