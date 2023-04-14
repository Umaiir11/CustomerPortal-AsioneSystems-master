import 'dart:convert';

import 'package:get/get.dart';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/ViewModel/VmSignup.dart';

class Sl_UserCreate {
  Future<bool> Fnc_UserCreate() async {
    final VmSignUp l_VmSignUp = Get.find<VmSignUp>();

    try {
      String lJsonString = json.encode(l_VmSignUp.lModuserlist.map((e) => e.toJson()).toList());

      List<int> lUtfContent = utf8.encode(lJsonString);

      final lResponse = await cmHttpCalls().Fnc_HttpWeb('/apiWeb/NewUser/PostUser', lUtfContent);
      print(lResponse);
      if (lResponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true; // always return Tuple1
  }
}
