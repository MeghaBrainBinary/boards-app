// ignore_for_file: depend_on_referenced_packages

import 'package:boards_app/screens/contact_us_screen/api/contct_us_model.dart';
import 'package:boards_app/utils/api_end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ContactUsApi{

 static Future<ContactUsModel> contactUsApi() async {
    try{
      var request = http.Request('GET', Uri.parse(ApiEndPoints.getSettings));


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var d = (await response.stream.bytesToString());
        return contactUsModelFromJson(d);
    }
    else {
    if (kDebugMode) {
      print(response.reasonPhrase);
    }
    return ContactUsModel();
    }

    }
    catch(e){
      return ContactUsModel();

    }
  }
}