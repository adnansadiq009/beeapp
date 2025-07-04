import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendFurnitureList extends StatelessWidget {
  final int? index;
  final Product data;

  const TrendFurnitureList({super.key, this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ThemeService>(
        builder: (context, home, theme, child) {
      return Container(
          width: MediaQuery.of(context).size.width,
          //decoration
          decoration: HomeWidget().trendFurnitureDecor(context),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.all(Insets.i6),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: HomeWidget().trendFurnitureImageDecor(context),
              child: CachedNetworkImage(
                imageUrl: data.firstImageUrl,
                fit: BoxFit.cover, // Changed to cover for full-width display
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ).paddingAll(Insets.i10),
            //subText layout
            Expanded(
                flex: 5,
                child: TrendFurnitureSubLayout(index: index, data: data)),
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Row(children: [
                //svg icon
                SvgPicture.asset(svgAssets.iconStar),
                const HSpace(Sizes.s2), //text layout
                Text(language(context, data.rating.toString()),
                    style: appCss.dmPoppinsRegular12
                        .textColor(isThemeColorReturn(context)))
              ]).paddingOnly(top: Insets.i10, left: Insets.i10),
              //cart button layout
              const VSpace(Sizes.s25),
              CommonCart(
                      imagePath: svgAssets.iconCart,
                      onTap: () => home.moveToCart(
                          index!,
                          home.newTrendFurniture as List<Map<String, dynamic>>,
                          context))
                  .paddingOnly(bottom: Insets.i10, left: Insets.i10)
            ]).paddingOnly(right: Insets.i8)
          ])).paddingOnly(bottom: Insets.i15);
    });
  }
}
