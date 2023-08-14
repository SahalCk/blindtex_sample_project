import 'package:http/http.dart';

class APIServices {
  final String url =
      'https://staging.tradeblindsdirect.com/api/v1/check_login.php';

  Future<StreamedResponse> loginAPIWithToken(
      String username, String password, String token) async {
    final formData = MultipartRequest('POST', Uri.parse(url));
    formData.fields.addAll({'username': username, 'password': password});
    formData.headers.addAll({'Access-Token': token});
    final response = await formData.send();
    return response;
  }
}
