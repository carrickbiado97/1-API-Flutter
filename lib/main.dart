import 'dart:convert';

import 'package:demo_api_flutter_using_dio/DataManager.dart';
import 'package:demo_api_flutter_using_dio/Entities/RequestSession.dart';
import 'package:demo_api_flutter_using_dio/Entities/ResponseToken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  getUserById();
                },
                child: const Text('Method Get Not Parameter')),
            TextButton(
                onPressed: () {
                  createRequestToken();
                },
                child: const Text('Method Get Constraint Parameter')),
            TextButton(
                onPressed: () {
                  createSessionWithLogin();
                },
                child: const Text('Method Post Constraint Parameter & Body')),
            TextButton(
                onPressed: () {
                  getListBriefDVC();
                },
                child: const Text('Method Get Constraint Parameter & Token Header')),
          ],
        ),
      ),
    );
  }
}

Future<void> getUserById() async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger());
  // customization
  // dio.interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: true,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90,
  //     request: true,
  //
  // ));
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
  if (kDebugMode) {
    print("Get User: ${response.data}");
  }
}

Future<void> createRequestToken() async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger());
  final response = await dio.get('https://api.themoviedb.org/3/authentication/token/new', queryParameters: {
    'api_key': 'bc8cc6e4b625e35697a3f2466dd628c6'
  });
  if (kDebugMode) {
    print("Request Token: ${response.data}");
    DataManager.instance.requestToken = ResponseToken.fromJson(response.data).requestToken.toString();
    print("Request Token: ${DataManager.instance.requestToken}");
  }
}

Future<void> createSessionWithLogin() async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
      request: true,
  ));
  final response = await dio.post('https://api.themoviedb.org/3/authentication/token/validate_with_login',
      queryParameters: {
        'api_key': 'bc8cc6e4b625e35697a3f2466dd628c6'
      },
      data: json.encode(RequestSession('smeb9716@gmail.com', 'Hiep97tb240297', DataManager.instance.requestToken).toJson())
      // data: RequestSession('smeb9716@gmail.com', 'Hiep97tb240297', DataManager.instance.requestToken)
      );
  if (kDebugMode) {
    print("Create Session: ${response.data}");
  }
}

Future<void> getListBriefDVC() async {
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: true,
    maxWidth: 90,
    request: true,
  ));
  final response = await dio.get('http://14.248.82.173:8321/BusinessService/efileProcessView',
      queryParameters: {'menuId': '240'},
      options: Options(
        headers: {
          'Authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJyZXZvdGVjaCIsImlhdCI6MTY3OTgxNzc1OCwiZXhwIjoxNjc5ODM5MzU4LCJ1c2VybmFtZSI6Imhhbmh0dC5ibnYifQ.Cmoj0xRm4QHJjooezJllgDPSwLHrwsfU6099GfXkOFCRYqubeJlai7TA26bZTaYqEKQrsc-XO6RBh86FJjDKubC_Lb-fBWHefft3mAwqUKmkpuoeQ_3NJt-srVQljN08N8Z6NNRPnAgQr7TQI7eOxXfqWETc8CFdkoEAeaU0PVTluMIyQfxw7z1l2iPtnVNSikOQzOwVch1oZUC9bnvKECxTBUP2PhSpLZCIx8WFpiN0I5EZPVdGswbNhziTn59kBujDV6bxlp39hdD-0S8rjtZa8A5j_EmZmTsyOqpVh-LuDY8OpNE5U2nuop65F1wSSqO46ln2xMbrHa3JJcyZqA'
        }
      )
  );
  if (kDebugMode) {
    print("List Brief: ${response.data}");
  }
}
