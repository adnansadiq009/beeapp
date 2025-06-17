import 'package:fuzzy/config.dart';

class TrendFurnitureShimmerLayout extends StatelessWidget {
  const TrendFurnitureShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpace(Sizes.s25),
        // Title shimmer
        Align(
          alignment: Alignment.centerLeft,
          child: const CommonShimmer(height: 20, width: 120)
              .paddingSymmetric(horizontal: Insets.i20),
        ),
        const VSpace(Sizes.s15),
        // List shimmer
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: ListView.builder(
            itemCount: 4, // Number of shimmer items
            padding: EdgeInsets.zero,
            itemBuilder: (_, __) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: HomeWidget().trendFurnitureDecor(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image shimmer
                    Container(
                      padding: const EdgeInsets.all(Insets.i6),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration:
                          HomeWidget().trendFurnitureImageDecor(context),
                      child: const CommonShimmer(
                          height: double.infinity, width: double.infinity),
                    ).paddingAll(Insets.i10),

                    // Title and subtitle shimmer
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonShimmer(height: 14, width: 150),
                          VSpace(6),
                          CommonShimmer(height: 14, width: 100),
                        ],
                      ),
                    ),

                    // Rating + cart shimmer
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonShimmer(height: 12, width: 40),
                        VSpace(Sizes.s25),
                        CommonShimmer(height: 30, width: 30),
                      ],
                    ).paddingOnly(right: Insets.i8),
                  ],
                ),
              ).paddingOnly(bottom: Insets.i15);
            },
          ),
        ),
      ],
    );
  }
}
