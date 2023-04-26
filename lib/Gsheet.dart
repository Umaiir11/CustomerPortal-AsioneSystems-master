import 'package:gsheets/gsheets.dart';
import 'package:login/MVVM/Model/ApiModels/ModContacts.dart';


//String sheetTitle = cmGlobalVariables.Pbtitle;
//String sheetNo = cmGlobalVariables.Pb_NO.toString();

class SheetAPI {
  static final cred = r'''
 {
  "type": "service_account",
  "project_id": "aisonenotifications",
  "private_key_id": "050b3f81f014d92b7861a9b1f65f440967268ab2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCj5O+QPISboqL1\nD4AqWDNN1iMKHkdsW54VAvurRj40SESw5h5Z+oyV8OZyngbKw7Jz+PO+g/o0LAJx\nv2w2vBUTMfA1JvJkjV+HHFSeuyTXa3RdrbLjB2Kha106P6oRy3hwj9Y9D3e09y9H\nm8TD2P7b3mDGf3wKMDxq2bfCEpPsis3+hK7siIQs7JVKstkxPFtEYsDCi+hWUwP0\nk22OmShiXT9UAtxRKq8YKPOy6YiuF6IidPuXzUpfkBki6FxHEaHCAROmGvLwTL7A\nAu4E1ew1E5eD8tIc8vT0sgws5ahNBGG5Ad6cz43aVrHSWRVv7zwA0A+Qw/NXwvw5\nGkLClUa3AgMBAAECggEANjWqG4442nWv6tjGrrrftVYn3tfnDes73X1QGvWv64Ef\n31cuINrjl1DIGI82dejG5N8qWBC1OH56DH+hXnVVjzTMW/hW4nV0bG8tehcyd2Je\nagHjEn7F29h0TKj0KtCfNLQOy8GK+bts0wWtzo2+tqDWZ7GRKJmN0lXTFwkoDmvO\nyNG6lTnkek75bHdD6QVcy97jDG/QWMiZn1zqRcALrI2GfqjRscxIA6cUlJY9Lf8X\nIdD5vgoUK0mTHORs+gj/uVmCHuhXuXVJlsZ37+EevcNwryUfrJxmdvm7LCz5f9HU\ndY9a1yrLuRjaPdXcSJZnfZIRTLcN5xSJQmOkH5cJCQKBgQDielfu7u7WsSWqRnI9\n6QBKC9AKgSnfhMVGd1x8JeCFCuBUXrAeLeoku1Mn7QUQZ8DVkqTyhCPuby2sSX87\nWYYB/nEFl7K6J7lSWj/B3FLfpywYI3sPDEPU2f+JrgjiwdaGw79Yyb0K+sRWiaQD\naCIoV8L/e9UvqX7cnD4e2Gt2BQKBgQC5Qib4YfpC5erw4X/8LYSLvpH+FBgbouHV\nKANBiszpDzjDXqyfYLjfTJV0JgmsXWN1JadMCbVCyq3QXVG5JnHw0mqo4JFoIZLz\nUrx3y6y98CvMxWJpfcgdK8igrrCtiXBvdgkcXnqaipT5bp2LQ5v+mpbcTG8wKdye\najiLqSAKiwKBgBPySoRUrtxhxbt1cOJa/xeGatBCB/oTq3xFTvPwMhIFnzRPEpvV\n12Vcyjod+fAz8xvcSoLBeJirWg5uerIzdEYArtubPLaAgSXrpOniCbqA8rU9ir0M\ni3zXplXt6gJuqAI+gz/CpM+uvlQQ000pgrii4h22PlRwTSgI6r+0t+IxAoGAJWGb\ny3K5tNX/2ismUBQ/MpN5kfMsCieLuh8gyRDg2AYiRgnMezxhEW26mn0yZn1RnEnE\nwCsVUCzlda3e16VSSG2s5/aoYIKlzENdlC6c5JaZv+/0M6UVxA0ZppKZQ+r/rP38\nSKUnyBc+iDYxw/AYgf9fgYRKy0UnJy/3yPaPaJECgYAQqbzUHolIP1TUBtBUJJ4h\nDN9NeMpZksfEdc8oZjUPSwANxGsxNw2sfFakWee52u8JHGzgCIp6uUe7bt341VdP\nUC5nbBoxCxVHtSOI5E86FO/h0qhHCCZi8Mfx7fLv92y4/cCPILsmojQPTWOVtufR\nYoJhTuEQM89gOJogRhYHJA==\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttercontacts@aisonenotifications.iam.gserviceaccount.com",
  "client_id": "109961460718105355413",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttercontacts%40aisonenotifications.iam.gserviceaccount.com"
}


  
  
  ''';
  static final spreadsheetID = "1CSDhqcycLhX7c38PpXlSLwbLIw8VXLTxDdTckR9x28w";

  static final gsheets = GSheets(cred);
  static Worksheet? usersheet;

  static Future init() async {
    try {
      final spreadsheet = await gsheets.spreadsheet(spreadsheetID);
      usersheet = await getWorkSheet(spreadsheet, title: "User121 Contacts");
      final firstrow = userfields.getFields();
      usersheet!.values.insertRow(1, firstrow);
    } catch (e) {
      print("Init Error: $e");
    }
  }

  static Future<Worksheet> getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.addWorksheet(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowlist) async {
    if (usersheet == null) return;

    usersheet!.values.map.appendRows(rowlist);
  }
}
