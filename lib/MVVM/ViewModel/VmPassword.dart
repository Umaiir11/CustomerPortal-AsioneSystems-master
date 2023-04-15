import 'package:get/get.dart';

class Vmpassword extends GetxController {

  RxBool Pr_autoValidate = false.obs;
  RxBool Pr_CheckBox = false.obs;

  RxString l_PrEmail = ''.obs;

  String get Pr_txtemail_Text {
    return l_PrEmail.value;
  }

  set Pr_txtemail_Text(String value) {
    l_PrEmail.value = value;
  }

  String? Pr_validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

}