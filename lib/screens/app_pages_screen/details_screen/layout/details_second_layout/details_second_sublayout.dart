import '../../../../../config.dart';

class DetailsSecondSubLayout extends StatelessWidget {
  final Product product;
  const DetailsSecondSubLayout({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //chair name text
        Expanded(
          child: Text(
            language(context, product.title),
            style: appCss.dmPoppinsSemiBold16
                .textColor(isThemeColorReturn(context)),
            maxLines: 2, // Ensure text wraps to second line if needed
            overflow:
                TextOverflow.ellipsis, // Add ellipsis if text exceeds 2 lines
          ).paddingSymmetric(horizontal: Insets.i20),
        ),
        //offer layout
        CommonOffLayout(discount: product.listForResale!.discount)
      ]).paddingOnly(top: Insets.i20),
      //details name,stepper,list layout of top data
      const DetailsSubLayoutOne(),
    ]);
  }
}
