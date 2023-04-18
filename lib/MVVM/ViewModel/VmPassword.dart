import 'package:get/get.dart';
import 'package:login/ClassModules/cmGlobalVariables.dart';
import 'package:login/MVVM/Model/ApiModels/ModForgetPass.dart';
import 'package:tuple/tuple.dart';

import '../../ServiceLayer/Sl_ForgetPassword.dart';

class Vmpassword extends GetxController {
  RxBool Pr_autoValidate = false.obs;
  RxBool Pr_CheckBox = false.obs;

  RxBool Pr_isLoading = false.obs;

  RxBool get Pr_isLoading_wid {
    return Pr_isLoading;
  }

  set Pr_isLoading_wid(RxBool value) {
    Pr_isLoading = value;
  }

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

  Future<bool> FncForgetPassword() async {
    Pr_isLoading_wid.value = true;
    List<ModForgetPassword>? lListForgetPassword = List<ModForgetPassword>.empty(growable: true);
    cmGlobalVariables.Pb_EmailID = Pr_txtemail_Text;
    print(cmGlobalVariables.Pb_EmailID);
    print(cmGlobalVariables.Pb_EmailID);
    final Tuple2<List<ModForgetPassword>?, Map<String, dynamic>?> forgetPasswordResult =
        await Sl_ForgetPassword().Fnc_ForgetPassword().timeout(const Duration(seconds: 10));
    Pr_isLoading_wid.value = false;

    lListForgetPassword = forgetPasswordResult.item1 ?? [];
    Map<String, dynamic>? item2 = forgetPasswordResult.item2;
    if (lListForgetPassword!.isNotEmpty) {
      print("DataLoaded");
      return true;
    } else {
      print("NotLoaded");
      return false;
    }
  }
}
