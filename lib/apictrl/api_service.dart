import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notmeet/apictrl/api.dart';
import 'package:notmeet/apictrl/api_model.dart';

class ApiService {
  // ignore: body_might_complete_normally_nullable
  Future<List<APIModel>?> getActivity() async {
    try {
      var url = Uri.parse(ApiActivity.baseUrl + ApiActivity.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<APIModel> apimodels = apiModelFromJson(response.body);
        return apimodels;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
