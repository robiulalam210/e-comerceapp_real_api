import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/model/OrderModel.dart';
import 'package:real_api/model/ProdactModel.dart';
import 'package:real_api/model/ProfileAllUser.dart';
import 'package:real_api/scrren/cont/common_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpRrequest {
  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "Application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    return header;
  }

  static Future<List<OrderModel>> OrderData() async {
    List<OrderModel> alldata = [];

    OrderModel orderModel;
    var response = await http.get(Uri.parse("${baseUrl}all/orders"),
        headers: await CustomHttpRrequest.getHeaderWithToken());
    var data = jsonDecode(response.body);

    for (var i in data) {
      orderModel = OrderModel.fromJson(i);
      alldata.add(orderModel);
    }
    return alldata;
  }

  static Future<List<CatagoryModel>> CatagoryDataAll() async {
    List<CatagoryModel> alldata = [];

    CatagoryModel catagoryModel;
    var response = await http.get(Uri.parse("${baseUrl}category"),
        headers: await CustomHttpRrequest.getHeaderWithToken());
    var data = jsonDecode(response.body);

    for (var i in data) {
      catagoryModel = CatagoryModel.fromJson(i);
      alldata.add(catagoryModel);
    }
    return alldata;
  }

  static Future<List<ProdactModel>> ProdactdataAll() async {
    List<ProdactModel> alldata = [];

    ProdactModel prodactModel;
    var response = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/products"),
        headers: await CustomHttpRrequest.getHeaderWithToken());
    var data = jsonDecode(response.body);

    for (var i in data) {
      prodactModel = ProdactModel.fromJson(i);
      alldata.add(prodactModel);
    }
    return alldata;
  }

  static Future<List<ProfileAllUser>> ProfileAllUserdataAll() async {
    List<ProfileAllUser> alldata = [];

    ProfileAllUser prodactModel;
    var response = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/all/user"),
        headers: await CustomHttpRrequest.getHeaderWithToken());
    var data = jsonDecode(response.body);

    for (var i in data) {
      prodactModel = ProfileAllUser.fromJson(i);
      alldata.add(prodactModel);
    }
    return alldata;
  }

  Future<dynamic> deleteProduct({required int id}) async {
    var link = "${baseUrl}product/$id/delete";
    var responce =
        await http.delete(Uri.parse(link), headers: await getHeaderWithToken());
    var data = jsonDecode(responce.body);
    return data;
  }

  Future<dynamic> deleteCatagory({required int id}) async {
    var link = "${baseUrl}category/$id/delete";
    var responce =
        await http.delete(Uri.parse(link), headers: await getHeaderWithToken());
    var data = jsonDecode(responce.body);
    return data;
  }
}
