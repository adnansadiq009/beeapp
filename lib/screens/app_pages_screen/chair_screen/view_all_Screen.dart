import 'package:fuzzy/plugin_list.dart';
import '../../../../config.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, CategoryProvider>(
        builder: (context, home, category, child) {
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
                  itemCount: home.newArrivalList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 0.63,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      maxCrossAxisExtent: 200),
                  itemBuilder: (context, index) {
                    //chair page sub layout
                    return ChairSubLayoutOne(
                        index: index, data: home.newArrivalList[index]);
                  }).paddingSymmetric(horizontal: Insets.i20)
            ])))),
      ));
    });
  }
}
