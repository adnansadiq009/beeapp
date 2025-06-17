import '../../../../../config.dart';

class DetailsTopContainer extends StatelessWidget {
  final Variant data;
  final bool isSelected;

  const DetailsTopContainer({
    super.key,
    required this.data,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s40,
      width: Sizes.s40,
      padding:
          const EdgeInsets.all(Insets.i6), // Reduced padding for better fit
      decoration: BoxDecoration(
        // Combine existing decoration with selection state
        // ...DetailsWidget().decorationTopContainer(context).boxShadow, // Preserve existing shadow
        color: isSelected
            ? appColor(context).appTheme.primaryColor.withOpacity(0.1)
            : DetailsWidget().decorationTopContainer(context).color,
        border: Border.all(
          color: isSelected
              ? appColor(context).appTheme.primaryColor
              : Colors.transparent,
          width: 1.5,
        ),
        borderRadius:
            DetailsWidget().decorationTopContainer(context).borderRadius,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Optional icon (uncomment if needed)
              // if (data['icon'] != null)
              //   SvgPicture.asset(
              //     data['icon'],
              //     height: Sizes.s16,
              //     color: isSelected
              //         ? appColor(context).appTheme.primaryColor
              //         : isThemeColorReturn(context),
              //   ),
              const SizedBox(height: Sizes.s2),
              Expanded(
                child: Text(
                  language(context, data.title),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: appCss.dmPoppinsRegular12.copyWith(
                    color: isSelected
                        ? appColor(context).appTheme.primaryColor
                        : isThemeColorReturn(context),
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          // Selection indicator in corner
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: Sizes.s12,
                height: Sizes.s12,
                decoration: BoxDecoration(
                  color: appColor(context).appTheme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: appColor(context).appTheme.whiteColor,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: Sizes.s8,
                  color: appColor(context).appTheme.whiteColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
