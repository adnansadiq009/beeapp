import 'package:fuzzy/plugin_list.dart';
import 'package:fuzzy/provider/prepaid_provider/prepaid_payment_provider.dart';
import '../../../../config.dart';

class OrderSubLayout extends StatelessWidget {
  final Color? color;

  const OrderSubLayout({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrepaidPaymentProvider>(
      builder: (context, prepaidProvider, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Insets.i15),
          decoration:
              CheckOutWidget().onlyDecor(context, color, isTheme(context)),
          child: Column(
            children: [
              CheckOutWidget().textDisplay(
                context,
                mainText: language(context, appFonts.subTotal),
                subText: language(context,
                    '${(currency(context).currencyVal * double.parse(language(context, appFonts.totalAmount))).round()}'),
              ),
              const VSpace(Sizes.s15),
              CheckOutWidget().textDisplay(
                context,
                mainText: language(context, appFonts.shippingCharges),
                subText: language(context,
                    '${(currency(context).currencyVal * double.parse(language(context, appFonts.amount))).round()}'),
              ),
              const VSpace(Sizes.s15),
              CheckOutWidget().textDisplay(
                context,
                mainText: language(context, appFonts.discount),
                subText: language(context,
                    '${(currency(context).currencyVal * double.parse(language(context, appFonts.discountAmount))).round()}'),
              ),
              const VSpace(Sizes.s15),
              CheckOutWidget().textDisplay(
                context,
                mainText: language(context, appFonts.paidAlready),
                subText:
                    '${getSymbol(context)}${(currency(context).currencyVal * prepaidProvider.amount).round()}',
              ),
              const VSpace(Sizes.s15),
              Divider(
                height: Sizes.s1,
                color: appColor(context).appTheme.lightText,
              ),
              const VSpace(Sizes.s15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    language(context, appFonts.amountDisplay),
                    style: appCss.dmPoppinsRegular13
                        .textColor(isThemeColorReturn(context)),
                  ),
                  Text(
                    language(context,
                        '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, appFonts.totalAmountCheckout)).round())}'),
                    overflow: TextOverflow.ellipsis,
                    style: appCss.dmPoppinsRegular13
                        .textColor(isThemeColorReturn(context)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
