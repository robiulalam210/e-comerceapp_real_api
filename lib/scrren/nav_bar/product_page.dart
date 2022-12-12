import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/ProdactModel.dart';
import 'package:http/http.dart' as http;
import 'package:real_api/peovider/prodact_provider.dart';
import 'package:real_api/scrren/cont/common_data.dart';
import 'package:real_api/scrren/data_add/add_product_page.dart';
import 'package:real_api/scrren/data_edit/edit_product_page.dart';

class ProdactPage extends StatefulWidget {
  const ProdactPage({Key? key}) : super(key: key);

  @override
  State<ProdactPage> createState() => _ProdactPageState();
}

class _ProdactPageState extends State<ProdactPage> {
  @override
  void initState() {
    Provider.of<ProdactProvider>(context, listen: false).getProdactList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = "https://apihomechef.antopolis.xyz/images/";
    final alldata =
        Provider.of<ProdactProvider>(context, listen: false).prodactListData;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.add),
        ),
        body: alldata.isEmpty
            ? spinkit
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 1, crossAxisSpacing: 2),
                shrinkWrap: true,
                itemCount: alldata.length,
                itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 2.0,
                      //  decoration: BoxDecoration(color: Colors.black),
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "$imageUrl${alldata[index].image}",
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  //  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${alldata[index].name}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Column(
                                        children: [
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProductPage(
                                                            productModel:
                                                                alldata[index],
                                                          )));
                                            },
                                            child: Container(
                                                height: 50,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                      child: Text("  Edit   ")),
                                                )),
                                          )),
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () async {
                                              var result =
                                                  await CustomHttpRrequest()
                                                      .deleteProduct(
                                                          id: alldata[index]
                                                              .id!
                                                              .toInt());
                                              print(
                                                  "result issssssssss${result}");
                                              if (result["error"] != null) {
                                                showTost("${result["error"]}");
                                              } else {
                                                showTost(
                                                    "${result["message"]}");
                                                Provider.of<ProdactProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteProductById(index);
                                              }
                                            },
                                            child: Container(
                                                height: 50,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                      child: Text("Delete")),
                                                )),
                                          )),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )));
  }
}
