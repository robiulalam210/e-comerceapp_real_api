import 'package:flutter/material.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/model/OrderModel.dart';
import 'package:real_api/model/ProdactModel.dart';
import 'package:real_api/model/ProfileAllUser.dart';
import 'package:real_api/scrren/nav_bar/product_page.dart';

class ProfileProvider with ChangeNotifier {
  List<ProfileAllUser> profileallUserListData = [];

  getAllUserList() async {
    profileallUserListData = await CustomHttpRrequest.ProfileAllUserdataAll();
    notifyListeners();
  }

}
