import 'dart:convert';

import '../ClassModules/cmHttpCalls.dart';
import 'package:tuple/tuple.dart';

class Sl_WebToken {
  Future<Tuple2<String?, Map<String, dynamic>?>> Fnc_WebToken() async {
    final lKey = 'A648423D-4CE5-47D2-B052-5222C9B6EDF5';
    try {
      final lResponse = await cmHttpCalls().Fnc_HttpWebToken('/apiWeb/Token/GetToken?l_Key=$lKey');
      if (lResponse.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(lResponse.body);
        final String token = responseJson['Item1'];
        final Map<String, dynamic>? item2 = responseJson['Item2']?.isNotEmpty == true ? responseJson['Item2'] : null;
        return Tuple2(token, item2);
      } else {
        return Tuple2(null, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return Tuple2(null, null);
  }
}
