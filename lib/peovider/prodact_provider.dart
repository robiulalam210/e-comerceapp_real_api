import 'package:flutter/material.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/model/OrderModel.dart';
import 'package:real_api/model/ProdactModel.dart';
import 'package:real_api/scrren/nav_bar/product_page.dart';

class ProdactProvider with ChangeNotifier {
  List<ProdactModel> prodactListData = [];

  getProdactList() async {
    prodactListData = await CustomHttpRrequest.ProdactdataAll();
    notifyListeners();
  }
  deleteProductById(int index) {
    prodactListData.removeAt(index);
    notifyListeners();
  }
}
