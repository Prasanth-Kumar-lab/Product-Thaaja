import 'package:get/get.dart';

class PasswordController extends GetxController {
  var oldPassword = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void changePassword() {
    if (newPassword.value == confirmPassword.value) {
      // Handle password change logic here
      Get.snackbar('Success', 'Password changed successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Passwords do not match!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}