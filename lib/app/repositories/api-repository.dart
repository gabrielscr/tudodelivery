import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudodelivery/app/utils/constants.dart';
import 'package:tudodelivery/app/utils/route.dart';

class ApiRepository {
  Dio dio = Dio();
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  Future<Response> get(String endpoint, Map<String, dynamic> params) async {
    final headers = await getHeaders();

    var response = await dio.get('${Constants.apiUrl}/$endpoint',
        queryParameters: params, options: Options(headers: headers));

    if (response.statusCode == 401) {
      goTo('login');
      return null;
    } else
      return response;
  }

  Future<Response> post(String endpoint, dynamic data) async {
    final headers = await getHeaders();

    return await dio.post('${Constants.apiUrl}/$endpoint',
        data: data, options: Options(headers: headers));
  }

  Future<Response> postData(String endpoint, dynamic data) async {
    final headers = await getHeadersPost();

    return await dio.post('${Constants.apiUrl}/$endpoint',
        data: data, options: Options(headers: headers));
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await getHeaders();

    return await dio.put('${Constants.apiUrl}/$endpoint',
        data: data, options: Options(headers: headers));
  }

  Future<Response> delete(String endpoint, Map<String, dynamic> params) async {
    final headers = await getHeaders();

    return await dio.delete('${Constants.apiUrl}/$endpoint',
        queryParameters: params, options: Options(headers: headers));
  }

  Future<Map<String, String>> getHeaders() async {
    final SharedPreferences prefs = await sharedPreferences;
    var token = prefs.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    return headers;
  }

  Future<Map<String, String>> getHeadersPost() async {
    final SharedPreferences prefs = await sharedPreferences;
    var token = prefs.getString('token');
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    return headers;
  }
}
