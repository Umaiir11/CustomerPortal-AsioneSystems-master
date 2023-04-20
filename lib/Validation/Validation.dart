import 'package:tuple/tuple.dart';

import '../MVVM/Model/ApiModels/ModUser.dart';

class DVMUser {
  static Tuple2<List<String>?, List<String>?> Fnc_Validate(ModUser l_ModUser) {
    List<String>? l_ErrorMsgs = [];
    List<String>? l_FieldNames = [];

    if (l_ModUser.Pr_FullName.isEmpty) {
      l_ErrorMsgs.add('Please enter your full name.');
      l_FieldNames.add('Pr_FullName');
    }

    if (l_ModUser.Pr_EmailID.isEmpty) {
      l_ErrorMsgs.add('Please enter your email id.');
      l_FieldNames.add('Pr_EmailID');
    } else {
      bool lIs_emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(l_ModUser.Pr_EmailID);
      if (!lIs_emailValid) {
        l_ErrorMsgs.add('Please enter a valid email id.');
        l_FieldNames.add('Pr_EmailID');
      }
    }
    if (l_ModUser.Pr_Password.isEmpty) {
      l_ErrorMsgs.add('Please enter your password.');
      l_FieldNames.add('Pr_Password');
    } else {
      if (l_ModUser.Pr_Password.length < 7) {
        l_ErrorMsgs.add('Password must be at least 7 characters long.');
        l_FieldNames.add('Pr_Password');
      }
      if (!l_ModUser.Pr_Password.contains(RegExp(r'[A-Z]'))) {
        l_ErrorMsgs.add('Password must contain at least one uppercase letter.');
        l_FieldNames.add('Pr_Password');
      }
      if (!l_ModUser.Pr_Password.contains(RegExp(r'[a-z]'))) {
        l_ErrorMsgs.add('Password must contain at least one lowercase letter.');
        l_FieldNames.add('Pr_Password');
      }
      if (!l_ModUser.Pr_Password.contains(RegExp(r'[0-9]'))) {
        l_ErrorMsgs.add('Password must contain at least one digit.');
        l_FieldNames.add('Pr_Password');
      }
    }

    if (l_ModUser.Pr_ContactNo.isEmpty) {
      l_ErrorMsgs.add('Please enter your contact number.');
      l_FieldNames.add('Pr_ContactNo');
    }

    // Add more field validation here as needed

    if (l_ErrorMsgs.isNotEmpty || l_FieldNames.isNotEmpty) {
      return Tuple2(l_ErrorMsgs, l_FieldNames);
    }

    return Tuple2(null, null);
  }
}
