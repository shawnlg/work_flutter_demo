import 'package:flutter/material.dart';
import 'package:work_demo_app/app_state.dart';
import 'package:work_demo_app/response_display.dart';
import 'package:work_demo_app/text_display.dart';
import 'package:work_demo_app/text_edit.dart';
import 'package:provider/provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:work_demo_app/plan_data.dart';

void main() {
  testService2();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextDisplay(),
                TextEditWidget(),
                RaisedButton(
                  onPressed: () => appState.fetchData(),
                  child: Text("Fetch Data from Network"),
                ),
                ResponseDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void testService() async {
  var url1 = "https://www.aetna.com/planSelSecure/um/member?id=16";
  var url2 = "https://www.aetna.com//planSelSecure/um/update?INPUT_ZIP_CODE=55124&INPUT_PLAN_YEAR=F&INPUT_EMPLOYEE_NAME=Shawn&INPUT_EMPLOYEE_AGE=8&INPUT_EMPLOYEE_GENDER=M&INPUT_EMPLOYEE_MBRINDEX=0";
  var url3 = "https://www.aetna.com/planSelSecure/um/selectServices?employeeUtilizationLevel=P";
  var uri1 = Uri.parse(url1);
  var uri2 = Uri.parse(url2);
  var uri3 = Uri.parse(url3);

  var cj=new CookieJar();
  var uri = Uri.parse('https://swapi.co/api/people/1');

  // request 1
  print("calling $url1");
  var request1 = await HttpClient().getUrl(uri1);
  request1.cookies.addAll(cj.loadForRequest(uri1));
  // sends the request
  var response1 = await request1.close();
  cj.saveFromResponse(uri1, response1.cookies);

  // transforms and prints the response
  await for (var contents in response1.transform(Utf8Decoder())) {
    print("response 1");
    print(contents);
  }

  // request 2
  print("calling $url2");
  var request2 = await HttpClient().getUrl(uri2);
  request2.cookies.addAll(cj.loadForRequest(uri2));
  // sends the request
  var response2 = await request2.close();
  cj.saveFromResponse(uri2, response2.cookies);

  // transforms and prints the response
  await for (var contents in response2.transform(Utf8Decoder())) {
    print("response 2");
    print(contents);
  }

  // request 3
  print("calling $url3");
  var request3 = await HttpClient().getUrl(uri3);
  request3.cookies.addAll(cj.loadForRequest(uri3));
  // sends the request
  var response3 = await request3.close();
  cj.saveFromResponse(uri3, response3.cookies);

  // transforms and prints the response
  await for (var contents in response3.transform(Utf8Decoder())) {
    print("response 3");
    print(contents);
  }
}

void testService2() async {
  var url = "https://www.aetna.com/planSelSecure/um/member?id=16";
  var s = PlanService();
  print("calling $url");
  var data = await s.callService(url);
  print("$data");
}

