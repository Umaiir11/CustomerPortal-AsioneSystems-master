import 'package:tuple/tuple.dart';

import '../MVVM/Model/ApiModels/ModUser.dart';

class DVMUser {
  static Tuple2<List<String>?, List<String>?> Fnc_Validate(ModUser lModUser) {
    List<String>? lErrorMsgs = [];
    List<String>? lFieldNames = [];

    if (lModUser.Pr_FullName.isEmpty) {
      lErrorMsgs.add('Please enter your full name.');
      lFieldNames.add('Pr_FullName');
    }

    if (lModUser.Pr_EmailID.isEmpty) {
      lErrorMsgs.add('Please enter your email id.');
      lFieldNames.add('Pr_EmailID');
    } else {
      bool lIsEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(lModUser.Pr_EmailID);
      if (!lIsEmailValid) {
        lErrorMsgs.add('Please enter a valid email id.');
        lFieldNames.add('Pr_EmailID');
      }
    }
    if (lModUser.Pr_Password.isEmpty) {
      lErrorMsgs.add('Please enter your password.');
      lFieldNames.add('Pr_Password');
    } else {
      if (lModUser.Pr_Password.length < 7) {
        lErrorMsgs.add('Password must be at least 7 characters long.');
        lFieldNames.add('Pr_Password');
      }
      if (!lModUser.Pr_Password.contains(RegExp(r'[A-Z]'))) {
        lErrorMsgs.add('Password must contain at least one uppercase letter.');
        lFieldNames.add('Pr_Password');
      }
      if (!lModUser.Pr_Password.contains(RegExp(r'[a-z]'))) {
        lErrorMsgs.add('Password must contain at least one lowercase letter.');
        lFieldNames.add('Pr_Password');
      }
      if (!lModUser.Pr_Password.contains(RegExp(r'[0-9]'))) {
        lErrorMsgs.add('Password must contain at least one digit.');
        lFieldNames.add('Pr_Password');
      }
    }

    if (lModUser.Pr_ContactNo.isEmpty) {
      lErrorMsgs.add('Please enter your contact number.');
      lFieldNames.add('Pr_ContactNo');
    }

    // Add more field validation here as needed

    if (lErrorMsgs.isNotEmpty || lFieldNames.isNotEmpty) {
      return Tuple2(lErrorMsgs, lFieldNames);
    }

    return const Tuple2(null, null);
  }
}
