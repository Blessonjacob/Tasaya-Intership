import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/controller.dart';

import '../models/categories_model.dart';
import '../models/offer_banner_model.dart';
import '../models/shop_model.dart';
import '../services/service.dart';

class GroceryController extends GetxController {
  MyController controller = Get.find<MyController>();
  RxList<String> carList = <String>[].obs;
  RxList<int> shopId = <int>[].obs;
  RxList<Datum> restuarantList = <Datum>[].obs;
  RxList<Datum> randomList = <Datum>[].obs;
  RxList<Banners> offerBannerList = <Banners>[].obs;
  RxList<CategoryList> catList = <CategoryList>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;

  List<String> imgList = [
    "https://img.icons8.com/external-smashingstocks-detailed-outline-smashing-stocks/344/external-grocery-ramadan-and-eid-smashingstocks-detailed-outline-smashing-stocks.png",
    "https://img.icons8.com/external-flatart-icons-outline-flatarticons/344/external-medicines-health-and-medical-flatart-icons-outline-flatarticons.png",
    "https://img.icons8.com/external-vitaliy-gorbachev-lineal-vitaly-gorbachev/344/external-burger-fast-food-vitaliy-gorbachev-lineal-vitaly-gorbachev-1.png",
    "https://img.icons8.com/external-wanicon-lineal-wanicon/344/external-skincare-beauty-cosmetics-wanicon-lineal-wanicon.png",
  ];
  Image errorImage = Image.asset('assets/images/tasaya1.png');

  getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    controller.isLoggedIn.value = prefs.getBool('isLogIn') ?? false;
    if (controller.isLoggedIn.value) {
      controller.useName.value = prefs.getString('userName') ?? '';
      controller.uid.value = prefs.getString('customer_id') ?? '';
      controller.emailAddress.value = prefs.getString('userEmail') ?? '';
      controller.phoneNumber.value = prefs.getString('userNumber') ?? '';
      controller.image.value = prefs.getString('image') ?? '';
    }
    update();
  }

  fetchRestuarants() async {
    isLoaded.value = false;
    var data = (await Services().getRestuarants());
    if (data != null) {
      restuarantList.value = data.data ?? [];
      if (restuarantList.isNotEmpty) {
        randomList = restuarantList;
        randomList.removeAt(0);
        randomList.shuffle();
        isLoaded.value = true;
      }
    }
    update();
  }

  fetchOfferBanner() async {
    isLoaded.value = false;
    carList.clear();
    shopId.clear();
    var data = (await Services().getOfferBanner());
    if (data != null) {
      offerBannerList.value = data.data ?? [];
      for (var i = 0; i < offerBannerList.length; i++) {
        carList.add('https://tasaya.in/${offerBannerList[i].offerImage}');
        shopId.add(int.parse(offerBannerList[i].shopId!));
      }
    } else {
      carList.add("https://img.freepik.com/premium-vector/woman-holding-grocery-bags-housewife-standing-self-service-cash-register-shopping-concept-modern-supermarket-building-exterior-full-length-horizontal_48369-28771.jpg?w=826");
    }
    isLoaded.value = true;
    update();
  }

  fetchCategories() async {
    isLoaded.value = false;
    var data = (await Services().getCategories());
    if (data != null) {
      catList.value = data.data ?? [];
    } else {
      Get.defaultDialog(content: const Text('Error Accured in Fetch Data, restart app.'));
    }
    isLoaded.value = true;
    update();
  }

  // getHomeApi() async {
  //   var res = await Services().homeAPI(int.parse(controller.uid!));
  //   if (res != null) {
  //     print('here');
  //     offerBannerList = res.data!.offerBanner!;
  //     for (var i = 0; i < offerBannerList!.length; i++) {
  //       carList.add('${offerBannerList![i].offerImage}');
  //       shopId.add(int.parse(offerBannerList![i].shopId!));
  //     }
  //     catList = res.data!.popularCategories;
  //     if (catList!.isNotEmpty && offerBannerList!.isNotEmpty) {
  //       setState(() {
  //         isLoaded = true;
  //       });
  //     }
  //   }
  // }

  Future<void> onLoad() async {
    await getPrefs();
    await fetchRestuarants();
    // await getHomeApi();
    await fetchOfferBanner();
    await fetchCategories();
    isLoaded.value = true;
    update();
  }

  @override
  void onInit() {
    onLoad();
    super.onInit();
  }
}
