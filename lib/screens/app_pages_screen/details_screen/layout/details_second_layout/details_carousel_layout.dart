import '../../../../../config.dart';
import '../../../../../plugin_list.dart';

class DetailsSecondCarouselLayout extends StatelessWidget {
  final List<ProductImage> productImages;
  const DetailsSecondCarouselLayout({super.key, required this.productImages});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, ThemeService>(
      builder: (context1, details, theme, child) {
        return Stack(
          children: [
            // Carousel slider widget
            SizedBox(
              width: double.infinity,
              child: CarouselSlider(
                carouselController: details.carouselController,
                items: productImages.asMap().entries.map((entry) {
                  final imageUrl = entry.value;
                  final isEnlarged = details.currentPage;
                  return DetailsWidget().alignImage(isEnlarged, imageUrl.url);
                }).toList(),
                options: CarouselOptions(
                  onPageChanged: (index, reason) => details.onChange(index),
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.7,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.bounceInOut,
                  disableCenter: false,
                  initialPage: 1,
                  height: Sizes.s300,
                  padEnds: false,
                  autoPlay: false,
                ),
              ),
            ),

            // Wishlist button positioned in bottom right
            Positioned(
              bottom: Insets.i20, // Adjust as needed
              right: Insets.i20, // Adjust as needed
              child: Container(
                decoration: BoxDecoration(
                  color: theme.isDarkMode
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(Insets.i8),
                child: CommonAppbarButtonDetails(
                  colorSvg: details.isWishlist
                      ? appColor(context).appTheme.linkErrorColor
                      : isTheme(context)
                          ? appColor(context).appTheme.whiteColor
                          : appColor(context).appTheme.primaryColor,
                  imagePath: details.isWishlist
                      ? svgAssets.iconWishlistOne
                      : svgAssets.iconWishlist,
                  onTap: () => details.onWishlistIn(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
