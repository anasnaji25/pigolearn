// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pigolearn_round1/data/appexceptions.dart';
import 'package:pigolearn_round1/data/network/BaseApiService.dart';

class NetworkApiService extends BaseApiService {

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse("https://owlbot.info/api/v4/dictionary/" + url),headers: {
        'Authorization': ' Token 08a5e3222b8be11a8bdcbaa455cb0f7ab1e7f608',
      });

      print(response.body.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        print("here.>>>>>>>>>>>>");
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}