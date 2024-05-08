import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_geolounge/core/extensions/logger.dart';

class AppObserver extends ProviderObserver {
  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    '🚮=====$provider was disposed======'.infoLogger();
    super.didDisposeProvider(provider, container);
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    '➕=======$provider was added====='.infoLogger();
    super.didAddProvider(provider, value, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    '🔃Update $provider, ◀️before: $previousValue,▶️ after: $newValue'
        .infoLogger();
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
