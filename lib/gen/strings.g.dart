/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 100 (50 per locale)
///
/// Built on 2024-05-02 at 10:41 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ar(languageCode: 'ar', build: _StringsAr.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsAuthEn auth = _StringsAuthEn._(_root);
	late final _StringsPostsEn posts = _StringsPostsEn._(_root);
	late final _StringsChatEn chat = _StringsChatEn._(_root);
	late final _StringsUserEn user = _StringsUserEn._(_root);
	late final _StringsDestinationsEn destinations = _StringsDestinationsEn._(_root);
	late final _StringsRoomsEn rooms = _StringsRoomsEn._(_root);
	late final _StringsAccountEn account = _StringsAccountEn._(_root);
}

// Path: auth
class _StringsAuthEn {
	_StringsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get onboarding_title => 'Unlock the Map, Enter The GeoLounge';
	String get onboarding_slogan => 'Anonymous Chats, Local & Global Bonds';
	String get google_sign_in => 'Sign in With Google';
	String get continue_guest => 'Continue as a guest';
}

// Path: posts
class _StringsPostsEn {
	_StringsPostsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get create_post => 'Create Post';
	String get post => 'Post';
	String get write_something => 'Write Something';
	String get select_room => 'Select A Room';
	String get choose_room => 'Choose a room to help people discover your post';
	String get nothing_to_show => 'Nothing to show here, Be the first!';
	String get something_wrong => 'Something went wrong, please try again';
	String get send_message => 'Send A Message';
	String get report => 'Report';
	String get reply_to => 'Reply to';
	String get delete => 'Delete Permanently';
	String get options => 'Options';
	String get go_back => 'Go Back';
}

// Path: chat
class _StringsChatEn {
	_StringsChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get chat_details => 'Chat Details';
	String get too_short => 'Too Short!';
	String get too_long => 'Too Long!';
	String get chats => 'Chats';
	String get options => 'Options';
	String get confirm_delete => 'Confirm Delete';
	String get are_you_sure => 'Are you sure you want to delete this chat permanently? This will delete the chat from both you and other user';
	String get delete => 'Delete';
	String get accept => 'Accept';
	String get reject => 'Reject';
	String get accepted => 'Accepted';
}

// Path: user
class _StringsUserEn {
	_StringsUserEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get need_location => 'We need your location to continue';
	String get get_location => 'Get Location';
}

// Path: destinations
class _StringsDestinationsEn {
	_StringsDestinationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get posts => 'Posts';
	String get chat => 'Chat';
	String get account => 'Account';
}

// Path: rooms
class _StringsRoomsEn {
	_StringsRoomsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get general => 'general';
	String get ask => 'ask';
	String get sport => 'sport';
	String get fun => 'fun';
	String get discussion => 'discussion';
	String get news => 'news';
}

// Path: account
class _StringsAccountEn {
	_StringsAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get language_changed => 'Language changed, please restart the app';
	String get account => 'Account';
	String get dark_theme => 'Dark Theme';
	String get language => 'Language';
	String get languages => 'Languages';
	String get privacy_policy => 'Privacy Policy';
	String get sign_out => 'Sign out';
	String get delete_account => 'Delete Account';
	String get delete_permanently => 'Delete Account Permanently';
	String get confirm_delete_account => 'Are you sure you want to delete your account permanently?This will delete all your information and you won\'t be able to restore them.';
	String get dismiss => 'Dismiss';
}

// Path: <root>
class _StringsAr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsAr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsAr _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsAuthAr auth = _StringsAuthAr._(_root);
	@override late final _StringsPostsAr posts = _StringsPostsAr._(_root);
	@override late final _StringsChatAr chat = _StringsChatAr._(_root);
	@override late final _StringsUserAr user = _StringsUserAr._(_root);
	@override late final _StringsDestinationsAr destinations = _StringsDestinationsAr._(_root);
	@override late final _StringsRoomsAr rooms = _StringsRoomsAr._(_root);
	@override late final _StringsAccountAr account = _StringsAccountAr._(_root);
}

// Path: auth
class _StringsAuthAr implements _StringsAuthEn {
	_StringsAuthAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get onboarding_title => 'فك الخريطة، وانغمس في الجيولاونج';
	@override String get onboarding_slogan => 'محادثات سرية، روابط محلية وعالمية';
	@override String get google_sign_in => 'سجل الدخول بقوقل';
	@override String get continue_guest => 'استمر كضيف';
}

// Path: posts
class _StringsPostsAr implements _StringsPostsEn {
	_StringsPostsAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get create_post => 'اكتب منشورًا';
	@override String get post => 'أنشر';
	@override String get write_something => 'اكتب شيئًا';
	@override String get select_room => 'اختر غرفةً';
	@override String get choose_room => 'اختر غرفةً لتساعد الاخرين على ايجاد منشورك';
	@override String get nothing_to_show => 'لا شيء لنعرضه هنا، كن الأول!';
	@override String get something_wrong => 'حدث خطآ ما، حاول مجددًا';
	@override String get send_message => 'ارسل رسالة';
	@override String get report => 'بلّغ';
	@override String get reply_to => 'رد على';
	@override String get delete => 'احذف نهائيًا';
	@override String get options => 'خيارات';
	@override String get go_back => 'ارجع';
}

// Path: chat
class _StringsChatAr implements _StringsChatEn {
	_StringsChatAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get chat_details => 'تفاصيل المحادثة';
	@override String get too_short => 'قصير بزيادة';
	@override String get too_long => 'طويل بزيادة';
	@override String get chats => 'محادثات';
	@override String get options => 'خيارات';
	@override String get confirm_delete => 'أكد الحذف';
	@override String get are_you_sure => 'متأكد تبي تحذف المحادثة نهائيًا؟ رح تختفي منك ومن الشخص الثاني';
	@override String get delete => 'احذف';
	@override String get accept => 'اقبل';
	@override String get reject => 'ارفض';
	@override String get accepted => 'قُبل';
}

// Path: user
class _StringsUserAr implements _StringsUserEn {
	_StringsUserAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get need_location => 'نحتاج موقعك لأستكمال التسجيل';
	@override String get get_location => 'خذ الموقع';
}

// Path: destinations
class _StringsDestinationsAr implements _StringsDestinationsEn {
	_StringsDestinationsAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get posts => 'منشورات';
	@override String get chat => 'محادثات';
	@override String get account => 'الحساب';
}

// Path: rooms
class _StringsRoomsAr implements _StringsRoomsEn {
	_StringsRoomsAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get general => 'عام';
	@override String get ask => 'اسأل';
	@override String get sport => 'رياضة';
	@override String get fun => 'فلة';
	@override String get discussion => 'نقاشات';
	@override String get news => 'اخبار';
}

// Path: account
class _StringsAccountAr implements _StringsAccountEn {
	_StringsAccountAr._(this._root);

	@override final _StringsAr _root; // ignore: unused_field

	// Translations
	@override String get language_changed => 'تغيرت اللغة، الرجاء اعد فتح التطبيق';
	@override String get account => 'الحساب';
	@override String get dark_theme => 'الوضع المظلم';
	@override String get language => 'اللغة';
	@override String get languages => 'اللغات';
	@override String get privacy_policy => 'سياسة الخصوصية';
	@override String get sign_out => 'سجل الخروج';
	@override String get delete_account => 'احذف الحساب';
	@override String get delete_permanently => 'احذف الحساب نهائيًا';
	@override String get confirm_delete_account => 'متـأكد من حذف الحساب نهائيًا؟ستُحذف جميع بياناتك نهائيًا ولن تستطيع استعادتها';
	@override String get dismiss => 'الغِ';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.onboarding_title': return 'Unlock the Map, Enter The GeoLounge';
			case 'auth.onboarding_slogan': return 'Anonymous Chats, Local & Global Bonds';
			case 'auth.google_sign_in': return 'Sign in With Google';
			case 'auth.continue_guest': return 'Continue as a guest';
			case 'posts.create_post': return 'Create Post';
			case 'posts.post': return 'Post';
			case 'posts.write_something': return 'Write Something';
			case 'posts.select_room': return 'Select A Room';
			case 'posts.choose_room': return 'Choose a room to help people discover your post';
			case 'posts.nothing_to_show': return 'Nothing to show here, Be the first!';
			case 'posts.something_wrong': return 'Something went wrong, please try again';
			case 'posts.send_message': return 'Send A Message';
			case 'posts.report': return 'Report';
			case 'posts.reply_to': return 'Reply to';
			case 'posts.delete': return 'Delete Permanently';
			case 'posts.options': return 'Options';
			case 'posts.go_back': return 'Go Back';
			case 'chat.chat_details': return 'Chat Details';
			case 'chat.too_short': return 'Too Short!';
			case 'chat.too_long': return 'Too Long!';
			case 'chat.chats': return 'Chats';
			case 'chat.options': return 'Options';
			case 'chat.confirm_delete': return 'Confirm Delete';
			case 'chat.are_you_sure': return 'Are you sure you want to delete this chat permanently? This will delete the chat from both you and other user';
			case 'chat.delete': return 'Delete';
			case 'chat.accept': return 'Accept';
			case 'chat.reject': return 'Reject';
			case 'chat.accepted': return 'Accepted';
			case 'user.need_location': return 'We need your location to continue';
			case 'user.get_location': return 'Get Location';
			case 'destinations.posts': return 'Posts';
			case 'destinations.chat': return 'Chat';
			case 'destinations.account': return 'Account';
			case 'rooms.general': return 'general';
			case 'rooms.ask': return 'ask';
			case 'rooms.sport': return 'sport';
			case 'rooms.fun': return 'fun';
			case 'rooms.discussion': return 'discussion';
			case 'rooms.news': return 'news';
			case 'account.language_changed': return 'Language changed, please restart the app';
			case 'account.account': return 'Account';
			case 'account.dark_theme': return 'Dark Theme';
			case 'account.language': return 'Language';
			case 'account.languages': return 'Languages';
			case 'account.privacy_policy': return 'Privacy Policy';
			case 'account.sign_out': return 'Sign out';
			case 'account.delete_account': return 'Delete Account';
			case 'account.delete_permanently': return 'Delete Account Permanently';
			case 'account.confirm_delete_account': return 'Are you sure you want to delete your account permanently?This will delete all your information and you won\'t be able to restore them.';
			case 'account.dismiss': return 'Dismiss';
			default: return null;
		}
	}
}

extension on _StringsAr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.onboarding_title': return 'فك الخريطة، وانغمس في الجيولاونج';
			case 'auth.onboarding_slogan': return 'محادثات سرية، روابط محلية وعالمية';
			case 'auth.google_sign_in': return 'سجل الدخول بقوقل';
			case 'auth.continue_guest': return 'استمر كضيف';
			case 'posts.create_post': return 'اكتب منشورًا';
			case 'posts.post': return 'أنشر';
			case 'posts.write_something': return 'اكتب شيئًا';
			case 'posts.select_room': return 'اختر غرفةً';
			case 'posts.choose_room': return 'اختر غرفةً لتساعد الاخرين على ايجاد منشورك';
			case 'posts.nothing_to_show': return 'لا شيء لنعرضه هنا، كن الأول!';
			case 'posts.something_wrong': return 'حدث خطآ ما، حاول مجددًا';
			case 'posts.send_message': return 'ارسل رسالة';
			case 'posts.report': return 'بلّغ';
			case 'posts.reply_to': return 'رد على';
			case 'posts.delete': return 'احذف نهائيًا';
			case 'posts.options': return 'خيارات';
			case 'posts.go_back': return 'ارجع';
			case 'chat.chat_details': return 'تفاصيل المحادثة';
			case 'chat.too_short': return 'قصير بزيادة';
			case 'chat.too_long': return 'طويل بزيادة';
			case 'chat.chats': return 'محادثات';
			case 'chat.options': return 'خيارات';
			case 'chat.confirm_delete': return 'أكد الحذف';
			case 'chat.are_you_sure': return 'متأكد تبي تحذف المحادثة نهائيًا؟ رح تختفي منك ومن الشخص الثاني';
			case 'chat.delete': return 'احذف';
			case 'chat.accept': return 'اقبل';
			case 'chat.reject': return 'ارفض';
			case 'chat.accepted': return 'قُبل';
			case 'user.need_location': return 'نحتاج موقعك لأستكمال التسجيل';
			case 'user.get_location': return 'خذ الموقع';
			case 'destinations.posts': return 'منشورات';
			case 'destinations.chat': return 'محادثات';
			case 'destinations.account': return 'الحساب';
			case 'rooms.general': return 'عام';
			case 'rooms.ask': return 'اسأل';
			case 'rooms.sport': return 'رياضة';
			case 'rooms.fun': return 'فلة';
			case 'rooms.discussion': return 'نقاشات';
			case 'rooms.news': return 'اخبار';
			case 'account.language_changed': return 'تغيرت اللغة، الرجاء اعد فتح التطبيق';
			case 'account.account': return 'الحساب';
			case 'account.dark_theme': return 'الوضع المظلم';
			case 'account.language': return 'اللغة';
			case 'account.languages': return 'اللغات';
			case 'account.privacy_policy': return 'سياسة الخصوصية';
			case 'account.sign_out': return 'سجل الخروج';
			case 'account.delete_account': return 'احذف الحساب';
			case 'account.delete_permanently': return 'احذف الحساب نهائيًا';
			case 'account.confirm_delete_account': return 'متـأكد من حذف الحساب نهائيًا؟ستُحذف جميع بياناتك نهائيًا ولن تستطيع استعادتها';
			case 'account.dismiss': return 'الغِ';
			default: return null;
		}
	}
}
