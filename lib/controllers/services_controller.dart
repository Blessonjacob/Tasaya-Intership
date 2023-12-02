import 'package:get/get.dart';
import 'package:tasaya_partner_application/view/register_page.dart';
import '../constants/constant_method.dart';


import '../models/services_category.dart';
import '../services/services_apis.dart';

class ServicesController extends GetxController {
  TasayaServices services = TasayaServices();

  RxList<TasayaServicesCategory> categoryList = <TasayaServicesCategory>[].obs;

  fetchCategory() async {
    var res = await services.fetchCategory();
    if (res != null) {
      if (res.status == true) {
        categoryList.value = res.categories!;
        categoryList.refresh();
        update();
      } else {
        successMsg('${res.responseMessage}', false);
      }
    }
  }

  bookService(String json) async {
    var res = await services.createOrder(json);
    if (res != null) {
      if (res.status == true) {
        successMsg('${res.responseMessage}', true);
        Get.offAll(() =>  RegisterPage());
      } else {
        successMsg('${res.responseMessage}', false);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }
}
