import 'dart:io';

import 'package:http/http.dart' as http;

import 'cmGlobalVariables.dart';

class cmHttpCalls {
  //Fnc_HttpResponseWebLogin,---- //
  Future<http.Response> Fnc_HttpWebToken(String lControllerUrl) async {
    Uri lUri = Uri.parse(cmGlobalVariables.Pb_WebAPIURL + lControllerUrl);
    final lResponse = await http.get(lUri);
    return lResponse;
  }

  Future<http.Response> Fnc_HttpWebCountries(String lControllerUrl) async {
    String? lToken;
    lToken = cmGlobalVariables.Pb_Token;
    Uri lUri = Uri.parse(cmGlobalVariables.Pb_WebAPIURL + lControllerUrl);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $lToken',
    };
    final lResponse = await http.get(lUri, headers: lStringContect);
    return lResponse;
  }

  Future<http.Response> Fnc_HttpWeb(String lControllerUrl, List<int> lUtfContent) async {
    String? lToken;
    lToken = cmGlobalVariables.Pb_Token;
    Uri lUri = Uri.parse(cmGlobalVariables.Pb_WebAPIURL + lControllerUrl);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $lToken',
    };
    final lResponse = await http.post(lUri, headers: lStringContect, body: lUtfContent);
    return lResponse;
  }

  Future<http.Response> Fnc_HttpWebCities() async {
    String? lToken;
    lToken = cmGlobalVariables.Pb_Token;
    String baseUrl = 'https://aisonesystems.com';
    String whereClause = "Where CountryDID=' ${cmGlobalVariables.Pb_SelectedCity}'";
    String lControllerUrl = '/apiWeb/CityQuery/Get';

    String url = baseUrl + lControllerUrl + '?Pr_WhereClause=${Uri.encodeQueryComponent(whereClause)}' + '&Pr_OrderByClause=';

    Uri lUri = Uri.parse(url);
    print(lUri);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $lToken',
    };
    final lResponse = await http.get(lUri, headers: lStringContect);
    return lResponse;
  }


  Future<http.Response> Fnc_HttpForgetPassword() async {
    String? lToken;
    lToken = cmGlobalVariables.Pb_Token;
    String baseUrl = 'https://aisonesystems.com';
    String whereClause = "WHERE EmailID='${cmGlobalVariables.Pb_EmailID}'";
    String lControllerUrl = '/apiWeb/User/Get';

    String url = baseUrl + lControllerUrl + '?Pr_WhereClause=${Uri.encodeQueryComponent(whereClause)}' + '&Pr_OrderByClause=';

    Uri lUri = Uri.parse(url);
    print(lUri);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $lToken',
    };
    final lResponse = await http.get(lUri, headers: lStringContect);
    return lResponse;
  }
}
