import 'dart:io';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';

class Age {
  String code;
  String display;
}

class PlanService {
  static const url1 = "https://www.aetna.com/planSelSecure/um/member?id=16";
  static const url2 = "https://www.aetna.com//planSelSecure/um/update?INPUT_ZIP_CODE=55124&INPUT_PLAN_YEAR=F&INPUT_EMPLOYEE_NAME=Shawn&INPUT_EMPLOYEE_AGE=8&INPUT_EMPLOYEE_GENDER=M&INPUT_EMPLOYEE_MBRINDEX=0";
  static const url3 = "https://www.aetna.com/planSelSecure/um/selectServices?employeeUtilizationLevel=P";

  var cj=new CookieJar();  // cookies for maintaining session between service calls

  Future<String> callService(url) async {
    final uri = Uri.parse(url);

    var request = await HttpClient().getUrl(uri);
    request.cookies.addAll(cj.loadForRequest(uri));
    // sends the request
    var response = await request.close();
    cj.saveFromResponse(uri, response.cookies);

    // transforms and prints the response
    await for (var contents in response.transform(Utf8Decoder())) {
      return contents;
    }
  }

  static List<Age> getAges(String data) {
    var ages = List<Age>();
    jsonDecode(data);

    return ages;
  }

}