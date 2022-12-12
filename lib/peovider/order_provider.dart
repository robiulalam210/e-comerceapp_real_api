import 'package:flutter/material.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/OrderModel.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderListData = [];

  getOrderList() async {
    orderListData = await CustomHttpRrequest.OrderData();
    notifyListeners();
  }

}
