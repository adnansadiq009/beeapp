import 'package:fuzzy/plugin_list.dart';
import '../../../config.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer6<CartProvider, WishlistProvider, PaymentProvider,
            ThemeService, AddressProvider, SelectedProductProvider>(
        builder: (context1, cart, wishlistProvider, payment, theme,
            addressProvider, selectedProduct, child) {
      final pricingProvider =
          Provider.of<PricingProvider>(context, listen: false);
      final product = selectedProduct.selectedProduct!;
      final variant = product.variants.first;
      final lineItem = selectedProduct.buildLineItems(
        variant: variant,
        quantity: 1, // or user-selected
      );
      return StatefulWrapper(
          //load event
          onInit: () => Future.delayed(const Duration(milliseconds: 10))
              .then((_) => cart.onReady(context)),
          //direction
          child: DirectionLayout(
              dChild: Scaffold(
                  backgroundColor:
                      appColor(context).appTheme.backGroundColorMain,
                  body: SafeArea(
                      child: Column(children: [
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                      // app layout
                      const AppbarSubLayout(),
                      //shipping address text layout
                      CheckOutWidget().mainAllText(context,
                          mainText:
                              language(context, appFonts.shippingAddress)),
                      //shipping address layout
                      const ShippingAddressSubLayout(),
                      //cart list data and sub layout divider
                      const CartListData(),

                      CheckOutWidget().mainAllText(context,
                          mainText: language(context, appFonts.paymentMethod)),
                      const VSpace(Sizes.s15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: PaymentWidget().decoPayment(context),
                        //payment wallet sub text layout
                        child: Column(
                          children: appArray.paymentMethod
                              .sublist(4, 6) // Get last two elements
                              .toList() // Convert reversed iterable to list
                              .asMap() // Create map with new indices
                              .entries
                              .map((e) {
                            return PaymentSubLayout(
                              index: e.key,
                              data: e.value,
                            ).inkWell(
                              onTap: () =>
                                  payment.onSelectPaymentMethod(e.value['id']),
                            );
                          }).toList(),
                        ),
                      ),
                      const VSpace(Sizes.s15),
                      CheckOutWidget().mainAllText(context,
                          mainText: language(context, appFonts.addYourProfit)),
                      const VSpace(Sizes.s6),
                      //text filed
                      SearchTextFieldCommon(
                        hintStyle: appCss.dmPoppinsRegular13
                            .textColor(appColor(context).appTheme.lightText),
                        prefixIcon: const Icon(Icons.money),
                        hintText: language(context, appFonts.addYourProfitHint),
                        keyboardType: TextInputType.number,
                        //controller: ,
                        // focusNode: ,
                        //validator: ,
                      ),
                      const VSpace(Sizes.s25),
                      //divider in checkout
                      CommonWidget().commonDivider(context),
                      const VSpace(Sizes.s20),
                      //choose shipping layout
                      const ChooseShippingSubLayout(),
                      const VSpace(Sizes.s25),
                      //divider in checkout
                      CommonWidget().commonDivider(context),
                      const VSpace(Sizes.s20),
                      //promo code text layout
                      // CheckOutWidget().mainAllText(context,
                      //     mainText: language(context, appFonts.promoCode)),
                      // const VSpace(Sizes.s10),
                      //promo code layout
                      // const PromoCodeSubLayout(),

                      // const VSpace(Sizes.s25),
                      //order info text layout
                      CheckOutWidget().mainAllText(context,
                          mainText: language(context, appFonts.orderInfo)),
                      const VSpace(Sizes.s15),
                      //order info layout
                      const OrderSubLayout(),
                      const VSpace(Sizes.s25),
                      //continue payment layout
                      ButtonCommon(
                          title: language(context, appFonts.continuePayment),
                          color: isThemeButtonColorReturn(context),
                          style: appCss.dmPoppinsRegular16
                              .textColor(isThemeColorReturnDark(context)),
                          radius: AppRadius.r10,
                          onTap: () {
                            final shipmentDetails =
                                addressProvider.getShipmentDetails();
                            print(shipmentDetails);
                            final newOrder = Order(
                                financialStatus: "pending",
                                fulfillmentStatus: "confirm",
                                productId: product.id!,
                                lineItems: lineItem,
                                shipmentDetails: shipmentDetails,
                                pricing: Pricing(
                                  subTotal: pricingProvider.subTotal,
                                  currentTotalPrice:
                                      pricingProvider.currentTotalPrice,
                                  paid: pricingProvider.paid,
                                  balance: pricingProvider.balance,
                                  shipping: pricingProvider.shipping,
                                  taxPercentage: pricingProvider.taxPercentage,
                                  taxValue: pricingProvider.taxValue,
                                  extra: pricingProvider.extra,
                                ),
                                status: "pending",
                                paymentMethod: "COD"

                                // other order info
                                );

                            // Now send `newOrder` to your API or order service
                          }

                          //  payment.onBtnPayNow(
                          //     context, payment)

                          ).paddingOnly(bottom: Insets.i10)
                    ])).paddingSymmetric(horizontal: Insets.i20))
                  ])))));
    });
  }
}
