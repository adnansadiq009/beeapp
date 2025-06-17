import '../../../config.dart';
import '../../../plugin_list.dart';

class SecondDetailsScreen extends StatelessWidget {
  const SecondDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer5<HomeProvider, SelectedProductProvider, DetailsProvider,
            ThemeService, DirectionProvider>(
        builder: (context2, home, product, details, theme, direction, child) {
      final detailProduct = product.selectedProduct!;
      //direction layout
      return DirectionLayout(
          dChild: Scaffold(
              backgroundColor: theme.isDarkMode ? Colors.black : Colors.white,
              body: SafeArea(
                  child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(children: [
                    //appbar layout on details 2 page
                    const SecondDetailsAppbar(),
                    //carousel layout on details 2 page
                    DetailsSecondCarouselLayout(
                            productImages: detailProduct.images)
                        .paddingOnly(top: 0, bottom: 0),
                    // const VSpace(Sizes.s42),
                    Column(children: [
                      //layout of product name,stepper,amount,offer,list layout product
                      DetailsSecondSubLayout(product: detailProduct),
                      //check delivery layout
                      // DetailsSecondCheckDeliveryLayout(),
                      //details layout
                      const DetailsSecondDetailLayout(),
                      // VSpace(Sizes.s10),
                    ]).paddingOnly(
                        bottom: MediaQuery.of(context).size.height * 0.11)
                  ])),
                  //bottom button layout cart
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: DetailsSecondBottomLayout()),
                ],
              ))));
    });
  }
}
