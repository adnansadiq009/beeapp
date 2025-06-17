import '../../../../config.dart';
import '../../../../plugin_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OfferZoneSubLayout extends StatelessWidget {
  final int? index;
  final Product data;

  const OfferZoneSubLayout({super.key, this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ThemeService>(
        builder: (context1, home, theme, child) {
      return Stack(children: [
        Container(
            //offer decoration layout
            decoration: HomeWidget().decorOfferZone(context),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.i18, vertical: Insets.i14),
                height: Sizes.s88,
                width: Sizes.s88,
                //offer decoration layout
                decoration: HomeWidget().offerZoneDecor(context),
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
              //offer text layout
              Expanded(
                child: OfferZoneTextLayout(
                  index: index,
                  data: data,
                ),
              )
            ]))
      ]);
    });
  }
}
