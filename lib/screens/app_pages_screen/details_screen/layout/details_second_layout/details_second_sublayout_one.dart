import 'package:fuzzy/plugin_list.dart';

import '../../../../../config.dart';

class DetailsSubLayoutOne extends StatelessWidget {
  const DetailsSubLayoutOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, SelectedProductProvider>(
        builder: (context, details, product, child) {
      final currentProduct = product.selectedProduct!;
      final index =
          details.selectedDetailIndexColor ?? 0; // Fallback to index 0
      final variant = currentProduct.variants[index];
      final inStock = variant.stock.available;
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VSpace(Sizes.s15),
        DetailsSecondSubLayoutOne(
            price: variant.discountedPrice, inStock: inStock),
        const VSpace(Sizes.s15),
        if (currentProduct.options != null && currentProduct.options!.isNotEmpty) ...[
          _buildSelectionWrap(
            context: context,
            items: appArray.detailsData,
            selectedIndex: details.selectedDetailIndexColor,
            onSelect: details.selectDetail,
          ),
          const VSpace(Sizes.s10),
          _buildSelectionWrap(
            context: context,
            items: appArray.detailsDataSizes,
            selectedIndex: details.selectedSizeIndex,
            onSelect: details.selectSize,
          ),
        ]
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //details list layout
        //     children: appArray.detailsData.asMap().entries.map((e) {
        //       return DetailsTopContainer(data: e.value);
        //     }).toList())
      ]).paddingOnly(left: Insets.i20, right: Insets.i20, bottom: Insets.i20);
    });
  }

  Widget _buildSelectionWrap({
    required BuildContext context,
    required List<dynamic> items,
    required int? selectedIndex,
    required Function(int) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final threeQuarterWidth = constraints.maxWidth * 0.75;
            final itemWidth = (threeQuarterWidth - 16) / 3;
            return SizedBox(
              width: threeQuarterWidth,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () => onSelect(index),
                    child: SizedBox(
                      width: itemWidth,
                      child: DetailsTopContainer(
                        data: item,
                        isSelected: isSelected,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
