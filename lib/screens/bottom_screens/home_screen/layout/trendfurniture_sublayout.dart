import '../../../../config.dart';
import '../../../../plugin_list.dart';

class TrendFurnitureSubLayout extends StatelessWidget {
  final int? index;
  final Product data;

  const TrendFurnitureSubLayout({super.key, this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, home, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //text layout
                      Text(language(context, data.title),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmPoppinsMedium14
                              .textColor(isThemeColorReturn(context))),
                    ]),
              )
            ]),
            const VSpace(Sizes.s15),
            Row(children: [
              //text layout
              Text(language(context, getFormattedPrice(context, data.price)),
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmPoppinsSemiBold15
                      .textColor(isThemeColorReturn(context))),
            ])
          ]).paddingSymmetric(vertical: Insets.i10);
    });
  }
}
