import 'package:fuzzy/config.dart';

class AddressProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  // TextEditingController landMarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // TextEditingController zipCodeController = TextEditingController();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  final FocusNode streetFocus = FocusNode();
  // final FocusNode landMarkFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  // final FocusNode zipCodeFocus = FocusNode();

  String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String value = "home";
  int selectRadio = 0;

  //select address
  selectAddressType(val, index) {
    value = val['title']!;
    selectRadio = index;
    notifyListeners();
  }

  ShipmentDetails getShipmentDetails() {
    final shipmentAddress = Address(
      name: nameController.text, // Or pass a real value
      address1: streetController.text,
      address2: streetController.text,
      company: "",

      city: City(
        city: cityController.text,
      ),
      phone: phoneNumberController.text,
    );

    return ShipmentDetails(
      email: '', // Optional: If you have an email field, use it
      addresses: [shipmentAddress],
    );
  }

  void disposeControllers() {
    nameController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    cityController.dispose();
  }
}
