import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:real_api/model/OrderModel.dart';
import 'package:real_api/peovider/order_provider.dart';
import 'package:real_api/scrren/cont/common_data.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    Provider.of<OrderProvider>(context,listen: false).getOrderList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final oderList = Provider.of<OrderProvider>(context).orderListData;
    return Scaffold(
        body: oderList.isEmpty?spinkit:ListView.builder(
            shrinkWrap: true,
            itemCount: oderList.length,
            itemBuilder: (context, index) => Container(
                    child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        "${oderList[index].id}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    trailing: Text(
                      "Price: ${oderList[index].price}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    title: Text(
                      "Name: ${oderList[index].user!.name}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Order: ${oderList[index].orderStatus!.orderStatusCategory!.name}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ))));
  }
}
