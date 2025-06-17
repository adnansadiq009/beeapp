import '../../../../../config.dart';
import '../../../../../plugin_list.dart';

class DetailsSecondBottomLayout extends StatelessWidget {
  const DetailsSecondBottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, theme, child) {
      return Stack(
        children: [
          Container(
            height: Sizes.s73,
            padding: const EdgeInsets.all(Insets.i10),
            width: MediaQuery.of(context).size.width,
            decoration: ShippingWidget().decorShipping(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button (left side) - unchanged
                ButtonCommon(
                  title: language(context, appFonts.download),
                  width: Sizes.s157,
                  height: Sizes.s48,
                  color: isTheme(context)
                      ? appColor(context).appTheme.transparentColor
                      : appColor(context).appTheme.searchBackground,
                  style: appCss.dmPoppinsRegular16
                      .textColor(appColor(context).appTheme.colorText),
                  radius: AppRadius.r10,
                  onTap: () => route.pop(context),
                ),

                // Modified Add to Cart button with icon
                SizedBox(
                  width: Sizes.s157,
                  height: Sizes.s48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isThemeButtonColorReturn(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.i8),
                    ),
                    onPressed: () =>
                        route.pushNamed(context, routeName.addNewAddress),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Cart icon with padding
                        Padding(
                          padding: const EdgeInsets.only(right: Insets.i8),
                          child: CommonWidget()
                              .svgAssetsOne(context, svgAssets.iconCart),
                        ),
                        // Text with price
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(language(context, appFonts.cartAdd),
                                style: appCss.dmPoppinsRegular16.textColor(
                                    isThemeColorReturnDark(context))),
                            // Text(
                            //     '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, appFonts.detailsPrice)).round())}',
                            //     style: appCss.dmPoppinsRegular12.textColor(
                            //         isThemeColorReturnDark(context))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

// class DetailsSecondBottomLayout extends StatelessWidget {
//   const DetailsSecondBottomLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeService>(builder: (context, theme, child) {
//       return Row(
//         children: [
//           Container(
//                   width: MediaQuery.sizeOf(context).width,
//                   height: Sizes.s52,
//                   //decoration
//                   decoration: DetailsWidget().decorationButton(context),
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: Insets.i20, vertical: Insets.i10),
//                   //bottom button layout
//                   child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                     ButtonCommon(
//                         title: language(context, appFonts.cancle),
//                         width: Sizes.s157,
//                         height: Sizes.s48,
//                         color: isTheme(context)
//                             ? appColor(context).appTheme.transparentColor
//                             : appColor(context).appTheme.searchBackground,
//                         style: appCss.dmPoppinsRegular16
//                             .textColor(appColor(context).appTheme.lightText),
//                         radius: AppRadius.r10,
//                         onTap: () => route.pop(context)),
//                     // const HSpace(Sizes.s10),
//                     //svg icon cart
//                     CommonWidget()
//                         .svgAssetsOne(context, svgAssets.iconCart)
//                         .paddingOnly(left: Insets.i5, right: Insets.i8),
//                     Column(children: [
//                       //add to cart text
//                       Text(language(context, appFonts.cartAdd),
//                           style: appCss.dmPoppinsRegular16.textColor(
//                               theme.isDarkMode
//                                   ? appColor(context).appTheme.primaryColor
//                                   : appColor(context).appTheme.whiteColor)),
//                       //divider
//                       // DetailsWidget().divider(context),
//                       // const HSpace(Sizes.s20),
//                       //amount
//                       Text(
//                           language(context,
//                               '${getSymbol(context)}${(currency(context).currencyVal * double.parse(language(context, appFonts.detailsPrice)).round())}'),
//                           overflow: TextOverflow.ellipsis,
//                           style: appCss.dmPoppinsRegular16
//                               .textColor(isThemeColorReturnDark(context)))
//                     ]).paddingSymmetric(horizontal: Insets.i20)
//                   ]))
//               .inkWell(
//                   onTap: () =>
//                       route.pushNamed(context, routeName.addNewAddress)),
//         ],
//       );
//     });
//   }
// }
