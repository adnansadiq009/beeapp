import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';

class ChairScreen extends StatelessWidget {
  const ChairScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, home, child) {
      return StatefulWrapper(
          //load event
          // onInit: () => Future.delayed(const Duration(milliseconds: 100))
          //     .then((_) => category.onReady()),
          //direction
          child: DirectionLayout(
        dChild: Scaffold(
            backgroundColor: appColor(context).appTheme.backGroundColorMain,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              //chair page appbar layout and filter layout
              const ChairAppbarLayout(),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: home.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 0.63,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      maxCrossAxisExtent: 200),
                  itemBuilder: (context, index) {
                    //chair page sub layout
                    return ChairSubLayoutOne(
                        index: index, data: home.filteredProducts[index]);
                  }).paddingSymmetric(horizontal: Insets.i20)
            ])))),
      ));
    });
  }
}
