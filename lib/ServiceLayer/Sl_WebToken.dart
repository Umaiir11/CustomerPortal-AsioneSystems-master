import '../ClassModules/cmHttpCalls.dart';

class Sl_WebToken {
  Future<String?> Fnc_WebToken() async {
    final lKey = 'A648423D-4CE5-47D2-B052-5222C9B6EDF5';
    try {
      final lResponse = await cmHttpCalls().Fnc_HttpWebToken('/apiWeb/Token/GetToken?l_Key=$lKey');
      if (lResponse.statusCode == 200) {
        return lResponse.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
