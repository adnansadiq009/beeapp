import '../config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommonContainerGrid extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Widget? widget;
  final Color? color;

  const CommonContainerGrid(
      {super.key,
      required this.imagePath,
      this.height,
      this.width,
      this.widget,
      this.color});

  @override
  Widget build(BuildContext context) {
    final double containerWidth = width ?? MediaQuery.of(context).size.width * 0.44;
    final double containerHeight = height ?? MediaQuery.of(context).size.height * 0.215;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: Insets.i8),
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r8)),
            color: color ?? appColor(context).appTheme.searchBackground,
          ),
        ),
        SizedBox(
          height: containerHeight,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(Insets.i10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r6)),
                  child: (imagePath.isEmpty || !imagePath.contains("http"))
                      ? Image.asset(
                    'assets/gif/gifEmptySearch.gif',
                    fit: BoxFit.cover,
                    width: 160,
                    height: 255,
                  )
                      : CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    width: 160,
                    height: 255,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/gif/gifEmptySearch.gif',
                      fit: BoxFit.cover,
                      width: 160,
                      height: 255,
                    ),
                  ),
                ),
              ),
              if (widget != null)
                Positioned(
                  left: 0,
                  right: -5,
                  bottom: 0,
                  child: widget!,
                ),
            ],
          ),
        ),
      ],
    );
  }


// @override
  // Widget build(BuildContext context) {
  //   return Stack(children: [
  //     //common gridview layout
  //     Container(
  //         padding: const EdgeInsets.only(bottom: Insets.i8),
  //         width: width ?? MediaQuery.of(context).size.width * 0.44,
  //         decoration: BoxDecoration(
  //             borderRadius:
  //                 const BorderRadius.all(Radius.circular(AppRadius.r8)),
  //             color: color ?? appColor(context).appTheme.searchBackground)),
  //     SizedBox(
  //         height: height ?? MediaQuery.of(context).size.height * 0.215,
  //         child: Stack(children: [
  //           Container(
  //               padding: const EdgeInsets.all(Insets.i10),
  //               height: MediaQuery.of(context).size.height * 0.203,
  //               width: MediaQuery.of(context).size.width * 0.44,
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: Insets.i25, vertical: Insets.i20),
  //                 height: MediaQuery.of(context).size.height * 0.17,
  //                 width: MediaQuery.of(context).size.width * 0.39,
  //                 decoration: BoxDecoration(
  //                     borderRadius:
  //                         const BorderRadius.all(Radius.circular(AppRadius.r6)),
  //                     color: appColor(context).appTheme.colorContainer),
  //                 child: (imagePath.isEmpty || !imagePath.contains("http"))
  //                     ? Image.asset(
  //                         'assets/gif/gifEmptySearch.gif', // Your fallback GIF
  //                         fit: BoxFit.cover,
  //                       )
  //                     : CachedNetworkImage(
  //                         imageUrl: imagePath,
  //                         fit: BoxFit.cover,
  //                         placeholder: (context, url) => Container(
  //                           color: Colors.grey[200],
  //                           child: const Center(
  //                               child: CircularProgressIndicator()),
  //                         ),
  //                         errorWidget: (context, url, error) => Image.asset(
  //                           'assets/gif/gifEmptySearch.gif',
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //               )),
  //           Positioned(
  //             left: 0,
  //             right: 0,
  //             bottom: 10,
  //             child: widget!,
  //           ),
  //         ]))
  //   ]);
  // }
}
