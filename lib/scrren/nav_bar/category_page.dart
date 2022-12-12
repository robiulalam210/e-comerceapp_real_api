import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/peovider/catagory_provider.dart';
import 'package:real_api/scrren/cont/common_data.dart';
import 'package:real_api/scrren/data_edit/edit_catagory_page.dart';

import '../data_add/add_category_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    Provider.of<CatagoryProvider>(context, listen: false).getCatagoryList();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alldata = Provider.of<CatagoryProvider>(context).catagoryListData;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddCategory()));
          },
          child: Icon(Icons.add),
        ),
        body: alldata.isEmpty
            ? spinkit
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
                shrinkWrap: true,
                itemCount: alldata.length,
                itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 4.0,
                      width: double.infinity,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Image.network(
                                            "$imageUrl${alldata[index].image}",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: Image.network(
                                              "$imageUrl${alldata[index].icon}",
                                              fit: BoxFit.cover,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " ${alldata[index].name}",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditCatagoryPage(
                                                            catagoryModel:
                                                                alldata[index],
                                                          )));
                                            },
                                            child: Container(
                                                height: 30,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                      child: Text("Edit Data")),
                                                )),
                                          )),
                                          Expanded(
                                              child: GestureDetector(
                                            onTap: () async {
                                              var result =
                                                  await CustomHttpRrequest()
                                                      .deleteCatagory(
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
                                                Provider.of<CatagoryProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteCataggoryById(index);
                                              }
                                            },
                                            child: Container(
                                                height: 30,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Center(
                                                      child: Text("Delete")),
                                                )),
                                          )),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )));
  }
}
