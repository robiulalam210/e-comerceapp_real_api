import 'package:flutter/material.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/model/OrderModel.dart';

class CatagoryProvider with ChangeNotifier {
  List<CatagoryModel> catagoryListData = [];

  getCatagoryList() async {
    catagoryListData = await CustomHttpRrequest.CatagoryDataAll();
    notifyListeners();
  }
  deleteCataggoryById(int index) {
    catagoryListData.removeAt(index);
    notifyListeners();
  }
}
