// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ogas_full_app/Model/API/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/pref_string.dart';
import 'base_service.dart';

enum APIType { aPost, aGet }

class ApiService extends BaseService {
  var response;
  String? token;
  Future<dynamic> getResponse(
      {@required APIType? apiType,
      @required String? url,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      bool fileUpload = false}) async {
    try {
      String mainUrl = baseURL + url!;
      print("URL ---> ${baseURL + url}");
      
      if (apiType == APIType.aGet) {
        var result = await http.get(Uri.parse(baseURL + url), headers: headers);
        print('*****************${result.body}');
        response = returnResponse(
          result.statusCode,
          result.body,
        );
        print("response......$response");
      } else if (fileUpload) {
        dio.FormData formData = dio.FormData.fromMap(body!);
        dio.Response result = await dio.Dio().post(baseURL + url,
            data: formData, options: dio.Options(contentType: "form-data"));
        print('responseType+>${result.data.runtimeType}');
        response = returnResponse(result.statusCode!, result.data);
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        token = pref.getString(PrefString.token);

        print('token is::::::$token');
        print("REQUEST ENCODE BODY $body");
        var result = await http.post(
          Uri.parse(mainUrl),
          headers: {'Authorization': '$token'},
          body: body,
        );
        print('RESULT>>>>>>$result');
        response = returnResponse(result.statusCode, result.body);
      }
      return response;
    } catch (e) {
      print('Error=>.. $e');
    }
  }

  returnResponse(int status, String result) {
    print("status$status");
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 256:
        return jsonDecode(result);

      case 400:
        throw BadRequestException('Bad Request');

      case 401:
        return jsonDecode(result);
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
