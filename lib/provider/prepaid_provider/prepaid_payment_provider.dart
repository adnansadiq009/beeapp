import 'dart:typed_data';
import 'package:fuzzy/config.dart';
import 'package:image_picker/image_picker.dart';

class PrepaidPaymentProvider extends ChangeNotifier {
  // Private state variables
  Uint8List? _uploadedImage;
  final TextEditingController _amountController =
      TextEditingController(text: '0');
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  Uint8List? get uploadedImage => _uploadedImage;
  TextEditingController get amountController => _amountController;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get canSubmit => _uploadedImage != null && _amountController.text != '0';
  double get amount => double.tryParse(_amountController.text) ?? 0.0;

  // Image handling methods
  Future<void> pickImageFromGallery() async {
    try {
      _setLoading(true);
      _clearError();

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        _setUploadedImage(bytes);
      }
    } catch (e) {
      _setError('Failed to pick image: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      _setLoading(true);
      _clearError();

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        _setUploadedImage(bytes);
      }
    } catch (e) {
      _setError('Failed to capture image: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void setImageFromDrop(Uint8List imageBytes) {
    try {
      _clearError();
      _setUploadedImage(imageBytes);
    } catch (e) {
      _setError('Failed to process dropped image: ${e.toString()}');
    }
  }

  void removeImage() {
    _uploadedImage = null;
    _clearError();
    notifyListeners();
  }

  // Amount handling methods
  void updateAmount(String value) {
    final double? parsedValue = double.tryParse(value);
    if (parsedValue == null || parsedValue < 0) {
      _setError('Please enter a valid amount');
      return;
    }

    _clearError();
    notifyListeners();
  }

  // Validation methods
  bool validateForm() {
    if (_uploadedImage == null) {
      _setError('Please upload a payment receipt image');
      return false;
    }

    if (amount <= 0) {
      _setError('Please enter a valid amount greater than 0');
      return false;
    }

    return true;
  }

  // Submission method
  Future<bool> submitPrepaidPayment(
      PaymentProvider paymentProvider, int paymentId) async {
    try {
      _setLoading(true);
      _clearError();

      if (!validateForm()) {
        return false;
      }

      // Here you would typically make an API call to submit the payment
      // For now, we'll simulate the submission
      await Future.delayed(const Duration(seconds: 1));

      // Call the payment provider method
      // paymentProvider.onSelectPaymentMethod(paymentId);

      return true;
    } catch (e) {
      _setError('Failed to submit payment: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Private helper methods
  void _setUploadedImage(Uint8List image) {
    _uploadedImage = image;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset method
  void reset() {
    _uploadedImage = null;
    _amountController.text = '0';
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
