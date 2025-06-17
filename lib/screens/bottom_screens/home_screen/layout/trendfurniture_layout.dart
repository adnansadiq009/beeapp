import '../../../../config.dart';
import '../../../../plugin_list.dart';

class TrendFurnitureLayout extends StatelessWidget {
  const TrendFurnitureLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, ThemeService>(
        builder: (context1, home, theme, child) {
      return Stack(children: [
        Column(children: [
          const VSpace(Sizes.s25),
          //trendFurniture name
          HomeWidget().listNameCommon(
              context, language(context, appFonts.trendFurniture)),
          const VSpace(Sizes.s15),
          //trendFurniture list and click event
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.55, // Adjust height for 4 items
            child: ListView.builder(
              itemCount: home.newTrendFurniture.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return TrendFurnitureList(
                  index: index,
                  data: home.newTrendFurniture[index],
                ).inkWell(
                    onTap: () => route.pushNamed(context, routeName.chairData));
              },
            ),
          )
        ])
      ]);
    });
  }
}
