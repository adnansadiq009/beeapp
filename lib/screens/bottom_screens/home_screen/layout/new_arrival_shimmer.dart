import 'package:fuzzy/config.dart';

class NewArrivalShimmerLayout extends StatelessWidget {
  const NewArrivalShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240, // total height needed for image + text shimmers
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonShimmer(height: 160, width: 140),
              SizedBox(height: 10),
              CommonShimmer(height: 14, width: 100),
              SizedBox(height: 6),
              CommonShimmer(height: 14, width: 80),
            ],
          ).paddingOnly(right: 12);
        },
      ),
    );
  }
}
