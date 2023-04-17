import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import '../../ClassModules/cmGlobalVariables.dart';
import '../../ServiceLayer/Sl_WebToken.dart';

class VmLogin extends GetxController{

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

  RxString l_PrPassword = ''.obs;

  String get Pr_txtpassword_Text {
    return l_PrPassword.value;
  }

  set Pr_txtpassword_Text(String value) {
    l_PrPassword.value = value;
  }

  String? Pr_validatepasword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }


  RxBool l_PrisSecurePassword = false.obs;

  RxBool get Pr_boolSecurePassword_wid {
    return l_PrisSecurePassword;
  }

  set Pr_boolSecurePassword_wid(RxBool value) {
    l_PrisSecurePassword = value;
  }




  FncWebToken() async {
    Tuple2<String?, Map<String, dynamic>?> result = await Sl_WebToken().Fnc_WebToken();
    cmGlobalVariables.Pb_Token = result.item1;
    print(cmGlobalVariables.Pb_Token);
  }

}