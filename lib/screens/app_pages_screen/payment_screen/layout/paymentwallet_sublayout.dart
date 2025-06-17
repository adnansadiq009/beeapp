import 'package:fuzzy/plugin_list.dart';
import 'package:fuzzy/provider/prepaid_provider/prepaid_payment_provider.dart';
import '../../../../config.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class PaymentSubLayout extends StatelessWidget {
  final int index;
  final dynamic data;
  const PaymentSubLayout({super.key, required this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context1, payment, child) {
      return Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            SizedBox(
                height: Sizes.s30,
                width: Sizes.s30,
                child: SvgPicture.asset(data['icon'].toString(),
                    fit: BoxFit.scaleDown)),
            Text(language(context, data['title'].toString()),
                    style: appCss.dmPoppinsRegular13
                        .textColor(isThemeColorReturn(context)))
                .paddingSymmetric(horizontal: Insets.i15)
          ]),
          // radio button
          CommonRadio(
            onTap: () {
              if (data['id'] == 6) {
                // Assuming ID 5 is prepaid/Cash on Delivery
                _showPrepaidDialog(context, payment, data['id']);
              } else {
                payment.onSelectPaymentMethod(data['id']);
              }
            },
            index: data['id'],
            selectedIndex: payment.selectIndex,
          )
        ]).paddingAll(Insets.i15),
        if (appArray.paymentMethod[index]['id'] != 4)
          //dotted line
          DottedLine(
              dashLength: Sizes.s5,
              dashGapLength: Sizes.s2,
              dashColor: appColor(context).appTheme.shadowColor)
      ]);
    });
  }

  void _showPrepaidDialog(
      BuildContext context, PaymentProvider payment, int paymentId) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (_) => PrepaidPaymentProvider(),
        child: Consumer<PrepaidPaymentProvider>(
          builder: (context, prepaidProvider, child) => Dialog(
            backgroundColor: appColor(context).appTheme.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            insetPadding: const EdgeInsets.all(Insets.i20),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 300, // Increased height to accommodate error messages
              padding: const EdgeInsets.all(Insets.i20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        language(context, "Paid Already"),
                        style: appCss.dmPoppinsMedium18
                            .textColor(appColor(context).appTheme.textColor),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: appColor(context).appTheme.containerZone,
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          border: Border.all(
                            color: appColor(context).appTheme.colorDivider,
                            width: 0.5,
                          ),
                        ),
                        child: TextField(
                          controller: prepaidProvider.amountController,
                          textAlign: TextAlign.center,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: appCss.dmPoppinsRegular14
                              .textColor(appColor(context).appTheme.textColor),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: prepaidProvider.updateAmount,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Insets.i15),

                  // Error message display
                  if (prepaidProvider.errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(Insets.i8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Text(
                        prepaidProvider.errorMessage!,
                        style: appCss.dmPoppinsRegular12.textColor(Colors.red),
                      ),
                    ),

                  if (prepaidProvider.errorMessage != null)
                    const SizedBox(height: Insets.i10),

                  // Upload container
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appColor(context).appTheme.whiteColor,
                        borderRadius: BorderRadius.circular(AppRadius.r12),
                        border: Border.all(
                          color: appColor(context).appTheme.colorDivider,
                          width: 1,
                        ),
                      ),
                      child: DragTarget<Uint8List>(
                        onAccept: prepaidProvider.setImageFromDrop,
                        builder: (context, candidateData, rejectedData) {
                          return GestureDetector(
                            onTap: prepaidProvider.isLoading
                                ? null
                                : prepaidProvider
                                    .pickImageFromGallery, // Direct gallery pick
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: prepaidProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : prepaidProvider.uploadedImage == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: appColor(context)
                                                    .appTheme
                                                    .textColor
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.cloud_upload_outlined,
                                                size: 24,
                                                color: appColor(context)
                                                    .appTheme
                                                    .textColor,
                                              ),
                                            ),
                                            const SizedBox(height: Insets.i15),
                                            Text(
                                              language(context,
                                                  "Drop or select images"),
                                              style: appCss.dmPoppinsRegular16
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .textColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadius.r8),
                                              child: Image.memory(
                                                prepaidProvider.uploadedImage!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
                                                onTap:
                                                    prepaidProvider.removeImage,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: Insets.i15),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: prepaidProvider.canSubmit &&
                              !prepaidProvider.isLoading
                          ? () async {
                              final success =
                                  await prepaidProvider.submitPrepaidPayment(
                                payment,
                                paymentId,
                              );
                              if (success && context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            appColor(context).appTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                      ),
                      child: prepaidProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              language(context, "Submit"),
                              style: appCss.dmPoppinsRegular14
                                  .textColor(Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
