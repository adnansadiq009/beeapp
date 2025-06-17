import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';

class NewArrivalSubLayoutOne extends StatelessWidget {
  final int index;
  final Product data;

  const NewArrivalSubLayoutOne(
      {super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context1, home, child) {
      return Stack(children: [
        //image display in gridview //add to cart button
        CommonContainerGrid(
          imagePath: data.firstImageUrl,
          widget: CommonCartButton(
            imagePath: svgAssets.iconCart,
            onTap: () => home.moveToCart(index,
                home.newArrivalList as List<Map<String, dynamic>>, context),
          ).paddingOnly(right: Insets.i9),
        ),
        //wishlist button
        CommonWishlistButton(
          imagePath: data.isInWishlist == true
              ? svgAssets.iconWishlistOne
              : svgAssets.iconWishlistTwo,
          onTap: () => home.moveToWishlist(index,
              home.newArrivalList as List<Map<String, dynamic>>, context),
        ),
        //subdata display and product click event to more product page
        NewArrivalSubLayout(
          index: index,
          data: data,
        ),
      ]).inkWell(onTap: () {
        Provider.of<SelectedProductProvider>(context, listen: false)
            .setSelectedProduct(data); // ✅ set the selected product
        route.pushNamed(
            context, routeName.detailsScreenSecond); // or use Navigator.push
      });
    });
  }
}
