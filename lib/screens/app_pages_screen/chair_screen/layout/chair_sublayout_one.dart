import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';

class ChairSubLayoutOne extends StatelessWidget {
  final int index;
  final Product data;

  const ChairSubLayoutOne({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context1, category, child) {
      return GestureDetector(
          onTap: () {
            Provider.of<SelectedProductProvider>(context, listen: false)
                .setSelectedProduct(data); // ✅ set the selected product
            route.pushNamed(context, routeName.detailsScreenSecond);
          },
          child: Stack(children: [
            //grid view layout
            CommonContainerGrid(
                imagePath: data.firstImageUrl,
                //cart button layout and click event
                widget: CommonCartButton(
                  imagePath: svgAssets.iconCart,
                  onTap: () => category.moveToCart(
                      index,
                      category.chairList as List<Map<String, dynamic>>,
                      context),
                ).paddingOnly(right: Insets.i9)),
            //chair page sub layout
            ChairSubLayout(index: index, data: data)
          ]));
    });
  }
}
