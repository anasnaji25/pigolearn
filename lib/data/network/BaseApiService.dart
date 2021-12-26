// ignore: file_names

// ignore_for_file: file_names

abstract class BaseApiService {

  final String baseUrl = "https://owlbot.info/api/v4/dictionary/";

  Future<dynamic> getResponse(String url);

}