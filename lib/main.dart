import 'package:flutter/services.dart';
import 'package:fuzzy/config.dart';
import 'package:fuzzy/plugin_list.dart';
import 'package:fuzzy/provider/prepaid_provider/prepaid_payment_provider.dart';
import 'package:fuzzy/screens/sp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  lockScreenPortrait();

  // Load SharedPreferences early
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Optional: Set token if saved
  final savedToken = prefs.getString('authToken');
  if (savedToken != null) {
    await ApiClient.setAuthToken(savedToken);
  }

  runApp(MyApp(isLoggedIn: isLoggedIn, prefs: prefs));
}

void lockScreenPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final SharedPreferences prefs;

  const MyApp({super.key, required this.isLoggedIn, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PrepaidPaymentProvider()),
          ChangeNotifierProvider(create: (_) => ThemeService(prefs)),
          ChangeNotifierProvider(create: (_) => LanguageProvider(prefs)),
          ChangeNotifierProvider(create: (_) => DirectionProvider(prefs)),
          ChangeNotifierProvider(create: (_) => SplashProvider()),
          ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
          ChangeNotifierProvider(
            create: (_) {
              final provider = LoginProvider();
              provider.init(); // <-- Call init to load saved "remember me"
              return provider;
            },
          ),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => RegistrationProvider()),
          ChangeNotifierProvider(create: (_) => ForgotProvider()),
          ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
          ChangeNotifierProvider(create: (_) => CreatePasswordProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => DashboardProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => WishlistProvider()),
          ChangeNotifierProvider(create: (_) => FilterProvider()),
          ChangeNotifierProvider(create: (_) => PaymentProvider()),
          ChangeNotifierProvider(create: (_) => ShippingProvider()),
          ChangeNotifierProvider(create: (_) => AddressProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => PageListProvider()),
          ChangeNotifierProvider(create: (_) => DetailsProvider()),
          ChangeNotifierProvider(create: (_) => CurrencyProvider(prefs)),
          ChangeNotifierProvider(create: (_) => HelpProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider(prefs)),
          ChangeNotifierProvider(create: (_) => SelectedProductProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PricingProvider())
        ],
        child:
        Consumer3<ThemeService, LanguageProvider, CurrencyProvider>(
            builder: (context, theme, lang, currency, child) {
              return MaterialApp(
                title: appFonts.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.fromType(ThemeType.light).themeData,
                darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                locale: lang.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  AppLocalizationDelagate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: appArray.localList,
                themeMode: theme.theme,

                // ✅ Set start page based on login
                // home: isLoggedIn ? const Dashboard() : const SpPage(),
                initialRoute: isLoggedIn ? "/Dashboard" : "/",
                routes: appRoute.route,
              );
            }));
  }
}


// import 'package:flutter/services.dart';
// import 'package:fuzzy/config.dart';
// import 'package:fuzzy/plugin_list.dart';
// import 'package:fuzzy/provider/prepaid_provider/prepaid_payment_provider.dart';
// import 'package:fuzzy/screens/sp.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await ApiClient.setAuthToken(
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImdpbW9rYTU1ODFAamVhbnNzaS5jb20iLCJleHAiOjE3NDkyMjgyODB9.2UoC5Hx4SLXKziR5tPk6kQbdT_B0p6JFIwnsKY1afhk");
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     lockScreenPortrait();
//     return FutureBuilder(
//         future: SharedPreferences.getInstance(),
//         builder: (context2, AsyncSnapshot<SharedPreferences> snapData) {
//           if (snapData.hasData) {
//             return MultiProvider(
//                 providers: [
//                   ChangeNotifierProvider(
//                       create: (_) => PrepaidPaymentProvider()),
//                   ChangeNotifierProvider(
//                       create: (_) => ThemeService(snapData.data!)),
//                   ChangeNotifierProvider(
//                       create: (_) => LanguageProvider(snapData.data!)),
//                   ChangeNotifierProvider(
//                       create: (_) => DirectionProvider(snapData.data!)),
//                   ChangeNotifierProvider(create: (_) => SplashProvider()),
//                   ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
//                   ChangeNotifierProvider(create: (_) => LoginProvider()),
//                   ChangeNotifierProvider(create: (_) => RegistrationProvider()),
//                   ChangeNotifierProvider(create: (_) => ForgotProvider()),
//                   ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
//                   ChangeNotifierProvider(
//                       create: (_) => CreatePasswordProvider()),
//                   ChangeNotifierProvider(create: (_) => HomeProvider()),
//                   ChangeNotifierProvider(create: (_) => DashboardProvider()),
//                   ChangeNotifierProvider(create: (_) => CategoryProvider()),
//                   ChangeNotifierProvider(create: (_) => CartProvider()),
//                   ChangeNotifierProvider(create: (_) => OrderProvider()),
//                   ChangeNotifierProvider(create: (_) => WishlistProvider()),
//                   ChangeNotifierProvider(create: (_) => FilterProvider()),
//                   ChangeNotifierProvider(create: (_) => PaymentProvider()),
//                   ChangeNotifierProvider(create: (_) => ShippingProvider()),
//                   ChangeNotifierProvider(create: (_) => AddressProvider()),
//                   ChangeNotifierProvider(create: (_) => ProfileProvider()),
//                   ChangeNotifierProvider(create: (_) => PageListProvider()),
//                   ChangeNotifierProvider(create: (_) => DetailsProvider()),
//                   ChangeNotifierProvider(
//                       create: (_) => CurrencyProvider(snapData.data!)),
//                   ChangeNotifierProvider(create: (_) => HelpProvider()),
//                   ChangeNotifierProvider(
//                       create: (_) => NotificationProvider(snapData.data!)),
//                   ChangeNotifierProvider(
//                       create: (_) => SelectedProductProvider()),
//                   ChangeNotifierProvider(create: (_) => UserProvider()),
//                   ChangeNotifierProvider(create: (_) => PricingProvider())
//                 ],
//                 child:
//                     Consumer3<ThemeService, LanguageProvider, CurrencyProvider>(
//                         builder: (context1, theme, lang, currency, child) {
//                   return MaterialApp(
//                       title: appFonts.appName,
//                       debugShowCheckedModeBanner: false,
//                       theme: AppTheme.fromType(ThemeType.light).themeData,
//                       darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
//                       locale: lang.locale,
//                       localizationsDelegates: const [
//                         AppLocalizations.delegate,
//                         AppLocalizationDelagate(),
//                         GlobalMaterialLocalizations.delegate,
//                         GlobalWidgetsLocalizations.delegate,
//                         GlobalCupertinoLocalizations.delegate
//                       ],
//                       supportedLocales: appArray.localList,
//                       themeMode: theme.theme,
//                       initialRoute: "/",
//                       routes: appRoute.route);
//                 }));
//           } else {
//             return MaterialApp(
//                 theme: AppTheme.fromType(ThemeType.light).themeData,
//                 darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
//                 themeMode: ThemeMode.light,
//                 debugShowCheckedModeBanner: false,
//                 home: const SpPage());
//           }
//         });
//   }
//   lockScreenPortrait() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }
// }
