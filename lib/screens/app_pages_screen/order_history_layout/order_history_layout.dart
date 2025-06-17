import 'package:fuzzy/config.dart';
import '../../../plugin_list.dart';

class OrderHistoryLayout extends StatelessWidget {
  const OrderHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderProvider, CategoryProvider>(
        builder: (context, order, category, child) {
      //direction layout
      return StatefulWrapper(
        onInit: () => Future.delayed(const Duration(milliseconds: 1000))
            .then((_) => order.onReady()),
        child: DirectionLayout(
            dChild: Scaffold(
                backgroundColor: appColor(context).appTheme.backGroundColorMain,
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  //order history appbar layout and filter layout
                  CommonAppBar(
                          isIcon: true,
                          appName: language(context, appFonts.orderHistory),
                          onPressed: () => route.pop(context))
                      .paddingOnly(top: Insets.i10),
                  //search widget
                  CommonWidget()
                      .filterLayout(category.searchCtrl, context)
                      .paddingOnly(top: Insets.i20),
                  const VSpace(Sizes.s20),
                  //order history list layout
                  ...order.orders
                      .asMap()
                      .entries
                      .map((e) =>
                          OrderHistorySubLayout(index: e.key, data: e.value))
                      .toList()
                ]).paddingSymmetric(horizontal: Insets.i20))))),
      );
    });
  }
}
