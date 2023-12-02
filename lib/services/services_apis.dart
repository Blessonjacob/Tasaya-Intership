import 'package:http/http.dart' as http;
import '../constants/constant_method.dart';

import '../models/services_category.dart';
import '../models/order_service_model.dart';

class TasayaServices {
  String baseUrl = 'https://tasaya-services.onrender.com/api/v1';
  Future<ServicesCategory?> fetchCategory() async {
    try {
      var res = await http.get(Uri.parse('$baseUrl/category/get'), headers: {
        "Access-Control_Allow_Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (res.statusCode == 200) {
        return servicesCategoryFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      successMsg(e.toString(), false);
    }
    return null;
  }

  Future<ServiceOrder?> createOrder(String body) async {
    try {
      var res = await http.post(
        Uri.parse('$baseUrl/order/create'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: body,
      );
      if (res.statusCode == 201 || res.statusCode == 500) {
        return serviceOrderFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      successMsg(e.toString(), false);
    }
    return null;
  }
}
