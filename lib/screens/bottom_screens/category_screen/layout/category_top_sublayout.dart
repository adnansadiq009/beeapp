import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';

class CategoryTopSubLayout extends StatelessWidget {
  final int? index;
  final Category data;

  const CategoryTopSubLayout({super.key, this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DirectionProvider, HomeProvider, CategoryProvider>(
        builder: (context, direction, home, category, child) {
      return GestureDetector(
          //more product page open
          onTap: () {
            final categoryName = data.name; // or data.name if it's a class
            home.filterProductsByCategory(categoryName);
            category.onSelectedCategory(
                index!, categoryName, context); // Keep your selection logic
          },
          child: Container(
                  width: MediaQuery.of(context).size.width * 0.77,
                  decoration: BoxDecoration(
                      borderRadius: direction.isDirection || isAr(context)
                          ? const BorderRadius.only(
                              topRight: Radius.circular(AppRadius.r8),
                              bottomRight: Radius.circular(AppRadius.r8))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.r8),
                              bottomLeft: Radius.circular(AppRadius.r8)),
                      color: appColor(context).appTheme.searchBackground),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //text layout
                              Text(language(context, data.name),
                                      style: appCss.dmPoppinsMedium16.textColor(
                                          isThemeColorReturn(context)))
                                  .paddingOnly(top: Insets.i15),
                              const VSpace(Sizes.s4), //text layout
                              //text layout
                              // Text(language(context, data.subCategory),
                              //     style: appCss.dmPoppinsRegular14.textColor(
                              //         appColor(context).appTheme.lightText))
                            ]),
                        //svg icon
                        CommonWidget()
                            .svgAssets(context, svgAssets.iconNextLongArrow)
                            .paddingOnly(bottom: Insets.i15, top: Insets.i20)
                      ]).paddingSymmetric(horizontal: Insets.i15))
              .paddingSymmetric(horizontal: Insets.i20));
    });
  }
}
