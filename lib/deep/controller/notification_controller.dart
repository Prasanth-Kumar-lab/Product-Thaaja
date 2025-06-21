import 'package:get/get.dart';

class NotificationController extends GetxController {
  var generalNotification = true.obs;
  var sound = false.obs;
  var soundCall = true.obs;
  var vibrate = false.obs;
  var payment = true.obs;
  var message = true.obs;
  var calls = false.obs;

  void toggleGeneralNotification() => generalNotification.value = !generalNotification.value;
  void toggleSound() => sound.value = !sound.value;
  void toggleSoundCall() => soundCall.value = !soundCall.value;
  void toggleVibrate() => vibrate.value = !vibrate.value;
  void togglePayment() => payment.value = !payment.value;
  void toggleMessage() => message.value = !message.value;
  void toggleCalls() => calls.value = !calls.value;
}