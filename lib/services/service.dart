import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address_added_model.dart';
import '../models/address_list_model.dart';
import '../models/categories_model.dart';
import '../models/coupon_applied_model.dart';
import '../models/coupon_list_model.dart';
import '../models/delete_address_model.dart';
import '../models/home_api_model.dart';
import '../models/locality_list_model.dart';
import '../models/login_model.dart';
import '../models/notification_model.dart';
import '../models/offer_banner_model.dart';
import '../models/common_model.dart';
import '../models/order_detail_model.dart';
import '../models/order_history_model.dart';
import '../models/registration_model.dart';
import '../models/restuarant_searching_model.dart';
import '../models/shop_details_model.dart';
import '../models/shop_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../constants/constant_method.dart';
import '../models/locality_list_model.dart';
import '../models/order_placed_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Services {
  String baseUrl = "https://tasaya.in/IOSApi/Customer";
  String baseUrl2 = 'https://tasaya.in/Api/Customer';

  void errorDailog(String text) {
    Get.defaultDialog(title: 'error accured', titleStyle: const TextStyle(color: Colors.redAccent), content: Text(text));
  }

  var client = http.Client();
  Future<http.Response> getLocationData(String text) async {
    http.Response response;

    response = await http.get(
      Uri.parse("http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"),
      headers: {"Content-Type": "application/json", "Access-Control_Allow_Origin": "*"},
    );

    return response;
  }

  Future<HomeApi?> homeAPI(int uid) async {
    try {
      var response = await client.post(Uri.parse("$baseUrl/home"),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
          body: jsonEncode(<String, dynamic>{
            "uid": uid,
          }));
      if (response.statusCode == 200) {
        return homeApiFromJson(response.body);
      } else {
        errorDailog(response.statusCode.toString());
      }
    } catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<RestuarantList?> getRestuarants() async {
    try {
      var uri = Uri.parse("$baseUrl/restaurant_list");
      var response = await client.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"});
      if (response.statusCode == 200) {
        var json = response.body;
        var data = restuarantListFromJson(json);
        return data;
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<OfferBanner?> getOfferBanner() async {
    try {
      var uri = Uri.parse("$baseUrl/get_offer_banner");
      var response = await client.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"});
      if (response.statusCode == 200) {
        var json = response.body;
        var data = offerBannerFromJson(json);
        return data;
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CategoriesList?> getCategories() async {
    try {
      var uri = Uri.parse("$baseUrl/category_list");
      var response = await client.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"});
      if (response.statusCode == 200) {
        var json = response.body;
        var data = categoriesFromJson(json);
        return data;
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<Login?> login(String phoneNumber, String password) async {
    printInfo(info: kIsWeb.toString());
    String fcmToken;
    if (kIsWeb) {
      fcmToken = 'eEjIOywnRfS4WCjKKunk23:APA91bHMNQdcKjV2Ltwy-aETcFwJCeZ-WRTJWFYiJ71yqXVFNTdw3RsNrj591-Zj_vALk_8SHjy36-AW4MCDgvgmQDWdfE7xTBvWopNUecvCiuDf3L-CXrs5pePxGmrgUD2ZTjAPiyAU';
    } else {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? 'eEjIOywnRfS4WCjKKunk23:APA91bHMNQdcKjV2Ltwy-aETcFwJCeZ-WRTJWFYiJ71yqXVFNTdw3RsNrj591-Zj_vALk_8SHjy36-AW4MCDgvgmQDWdfE7xTBvWopNUecvCiuDf3L-CXrs5pePxGmrgUD2ZTjAPiyAU';
    }

    try {
      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'mobile': phoneNumber, 'password': password, 'imei': "0c61cf4802879159", "firebase_token": fcmToken},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return loginFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<Login?> googleLogin(String phoneNumber, String displayName, String email, String accessToken, String image) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/google_login'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(<String, String>{"customer_name": displayName, "customer_mobile": phoneNumber, "customer_email": email, "google_token": accessToken, "google_image": image}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return loginFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<ShopDetails?> shopGetById(String shopId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/get_shop_by_id'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'shop_id': shopId},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return shopDetailsFromJson(response.body);
      } else {
        errorDailog(response.statusCode.toString());
      }
    } on Exception catch (e) {
      errorDailog("$e");
    }
    return null;
  }

  Future<CommonModel?> forgotPassword(String phoneNumber) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/forgot'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'mobile': phoneNumber},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return commonModelFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CommonModel?> otpSend(String phoneNumber, int uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/CheckMobile'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{'uid': uid, 'mobile': phoneNumber},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return commonModelFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CommonModel?> otpVerify(String phoneNumber, String otp) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/OtpVarification'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'mobile': phoneNumber, 'otp': otp},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return commonModelFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CommonModel?> changepassword(String phoneNumber, String newPassword) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/changepass'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'mobile': phoneNumber, 'password': newPassword},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return commonModelFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<Registration?> registration(String name, String email, String phoneNumber, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "name": name,
            "email": email,
            "mobile": phoneNumber,
            "password": password,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return registrationFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<NotificationModel?> notification(String uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/notification'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'uid': uid},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return notificationFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<AddressList?> getAddressList(String uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/address_list'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control_Allow_Origin": "*",
        },
        body: jsonEncode(
          <String, String>{'uid': uid},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return addressListFromJson(response.body);
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<OrderPlaced?> orderPlaced(int uid, String date, int addID, int total, List<dynamic> products) async {
    try {
      var req = jsonEncode(
        <String, dynamic>{
          "uid": uid,
          "ddate": date,
          "timesloat": "12PM",
          "p_method": "cash on delievery",
          "address_id": addID,
          "tax": 2,
          "tid": 8,
          "total": total,
          "pname": products,
        },
      );
      print(req);
      final response = await client.post(
        Uri.parse('$baseUrl2/placeorder'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control_Allow_Origin": "*",
        },
        body: req,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('response body : ${response.body}');
        return orderPlacedFromJson(response.body);
      } else {
        successMsg('Response reveice from Server : ${response.statusCode}', false);
      }
    } on Exception catch (e) {
      successMsg('$e', false);
    }
    return null;
  }

  Future<OrderHistory?> getOrderHistory(String uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/order_list'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, String>{'uid': uid},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return orderHistoryFromJson(response.body);
      } else {
        errorDailog('${response.statusCode}');
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<AddressAdded?> addAddress(String uid, LatLng position, String addressLine, String houseNumber, String apartment, String directionToReach, String type, String locality) async {
    try {
      var response = await client.post(Uri.parse('$baseUrl/address'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
          body: jsonEncode(<String, String>{
            "uid": uid,
            "latitute": position.latitude.toString(),
            "longtitute": position.longitude.toString(),
            "type": type,
            "address_line": addressLine,
            "house_number": houseNumber,
            "apartment": apartment,
            "direction_to_reach": directionToReach,
            "pincode": locality
          }));

      if (response.statusCode == 200) {
        return addressAddedFromJson(response.body);
      } else {
        errorDailog('${response.statusCode}');
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<AddressAdded?> defualtAddress(String uid, LatLng position, String addressLine, String houseNumber, String apartment, String directionToReach, String type) async {
    try {
      var response = await client.post(Uri.parse('$baseUrl/default_address'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
          body: jsonEncode(<String, String>{
            "uid": uid,
            "latitute": position.latitude.toString(),
            "longtitute": position.longitude.toString(),
            "type": type,
            "address_line": addressLine,
            "house_number": houseNumber,
            "apartment": apartment,
            "direction_to_reach": directionToReach,
          }));
      if (response.statusCode == 200) {
        return addressAddedFromJson(response.body);
      } else {
        errorDailog('${response.statusCode}');
        return null;
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<AddressAdded?> updateAddress(String uid, String addressLine, String houseNumber, String apartment, String directionToReach, String type) async {
    try {
      var response = await client.post(Uri.parse('$baseUrl/address'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
          body: jsonEncode(<String, String>{
            "uid": uid,
            "type": type,
            "address_line": addressLine,
            "house_number": houseNumber,
            "apartment": apartment,
            "direction_to_reach": directionToReach,
          }));
      if (response.statusCode == 200) {
        return addressAddedFromJson(response.body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<DeleteAddress?> deleteAddress(int uid, int addID) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/delete_address'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            'uid': uid,
            "aid": addID,
          },
        ),
      );
      if (response.statusCode == 200) {
        return deleteAddressFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CommonModel?> addToFavorite(int uid, int orderID) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/addOrderToFavourite'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            "order_id": orderID,
            "customer_id": uid,
          },
        ),
      );
      if (response.statusCode == 200) {
        return commonModelFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<OrderHistory?> getFavoriteOrders(int uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/favouriteOrderList'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            'customer_id': uid,
          },
        ),
      );
      if (response.statusCode == 200) {
        return orderHistoryFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CommonModel?> shopReview(String msg, String rate, int shopID, int uid) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/shopReview'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            "msg": msg,
            "rate": rate,
            "shop_id": shopID,
            "uid": uid,
          },
        ),
      );
      if (response.statusCode == 200) {
        return commonModelFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<OrderDetailModel?> getOrderDetail(int uid, int id) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/order_details'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            "uid": uid,
            "id": id,
          },
        ),
      );
      if (response.statusCode == 200) {
        return orderDetailModelFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<OrderPlaced?> repeatOrder(int oid) async {
    log('oid : $oid');
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/repeat_order'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            "oid": oid,
          },
        ),
      );
      if (response.statusCode == 200) {
        return orderPlacedFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<RestuarantSearching?> searchRestuarant(String searchKey, String locality) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/restaurant_searching'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: jsonEncode(
          <String, dynamic>{
            "search_key": searchKey,
            "pincode": locality,
          },
        ),
      );
      if (response.statusCode == 200) {
        return restuarantSearchingFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CouponList?> getCouponList() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/coupon_code_list'), headers: {'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"});
      if (response.statusCode == 200) {
        return couponListFromJson(response.body);
      }
      return null;
    } on Exception catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<CouponApplied?> getCouponApllies(String couponCode, double total) async {
    try {
      final response = await client.post(Uri.parse('$baseUrl/apply_coupon_code'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
          body: jsonEncode(<String, dynamic>{
            "coupon_code": couponCode,
            "total": total,
          }));
      if (response.statusCode == 200) {
        return couponAppliedFromJson(response.body);
      }
      return null;
    } catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<LocalityList?> localityList() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/locality_list'), headers: {'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"});
      if (response.statusCode == 200) {
        return localityListFromJson(response.body);
      }
      return null;
    } catch (e) {
      errorDailog('$e');
    }
    return null;
  }

  Future<dynamic> getMessageById(String id) async {
    try {
      var res = await http.get(Uri.parse('$baseUrl/message/get'));
      if (res.statusCode == 200) {
        return res.body;
      } else {
        log('Server return status code : ${res.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error : $e');
    }
  }

  Future<void> createMessage(String firstName, String lastName, String id, String profile, String text) async {
    try {
      var req = jsonEncode({
        "author": {
          "firstName": firstName,
          "lastName": lastName,
          "id": id,
        },
        // "createdAt": DateTime.now().millisecondsSinceEpoch,
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": '$firstName $lastName',
        "status": "seen",
        "text": text,
        "type": "text"
      });
      log('req :: $req');
      var res = await http.post(
        Uri.parse('$baseUrl/message/create'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', "Access-Control_Allow_Origin": "*"},
        body: req,
      );
      if (res.statusCode == 201) {
        log('Message created :::');
      } else {
        log('Server return status code : ${res.statusCode}');
      }
    } catch (e) {
      log('Error : $e');
    }
  }
}
