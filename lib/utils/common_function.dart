import 'package:fuzzy/plugin_list.dart';
import '../config.dart';
import 'package:intl/intl.dart';

//dashboard page moving time route clear
isDashboard(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => MultiProvider(providers: [
                ChangeNotifierProvider(create: (_) => DashboardProvider()),
                ChangeNotifierProvider(create: (_) => HomeProvider()),
              ], child: const Dashboard())),
      ModalRoute.withName(routeName.dashboard));
}

//change currency time calling
CurrencyProvider currency(context) {
  final currencyData = Provider.of<CurrencyProvider>(context, listen: false);
  return currencyData;
}

//change currency time symbol change
getSymbol(context) {
  final currencyData =
      Provider.of<CurrencyProvider>(context, listen: true).priceSymbol;
  return currencyData;
}

//change theme that time calling
isThemeColorReturn(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.whiteColor
      : appColor(context).appTheme.primaryColor;
}

//change theme that time calling
isThemeColorReturnDark(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.primaryColor
      : appColor(context).appTheme.whiteColor;
}

//change theme that time calling button color change
isThemeButtonColorReturn(context) {
  return appColor(context).isDarkMode
      ? appColor(context).appTheme.btnPrimaryColor
      : appColor(context).appTheme.primaryColor;
}

//change language to use translate language
String language(context, text) {
  return AppLocalizations.of(context)!.translate(text);
}

//formated date
// String getFormattedPrice(BuildContext context, double amount) {
//   final currencyData = Provider.of<CurrencyProvider>(context, listen: true);
//   final formattedAmount = NumberFormat.currency(
//     decimalDigits: 0, // No decimal places
//     symbol: '', // We'll handle the symbol separately
//   ).format(amount);

//   return '${currencyData.priceSymbol}$formattedAmount';
// }
String getFormattedPrice(BuildContext context, num rawPrice) {
  final num finalPrice = currency(context).currencyVal * rawPrice;
  final formatter = NumberFormat("#,##0", "en_US");
  return "${getSymbol(context)}${formatter.format(finalPrice.round())}";
}

//language select arabic to check arabic for direction
bool isAr(context) {
  return AppLocalizations.of(context)?.locale.languageCode == "ar";
}

//check theme mode
isTheme(context) {
  final theme = Provider.of<ThemeService>(context, listen: false);
  return theme.isDarkMode;
}

//use to select direction
isDirectionRTL(context) {
  final direction = Provider.of<DirectionProvider>(context, listen: false);
  return direction.isDirection;
}
