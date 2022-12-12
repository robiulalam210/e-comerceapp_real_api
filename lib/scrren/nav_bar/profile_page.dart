import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:http/http.dart' as http;
import 'package:real_api/peovider/all_user_provider.dart';
import 'package:real_api/scrren/cont/common_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    dataaAll();
    Provider.of<ProfileProvider>(context, listen: false).getAllUserList();

    // TODO: implement initState
    super.initState();
  }

  var alldata;

  Future dataaAll() async {
    try {
      var response = await http.get(
          Uri.parse("https://apihomechef.antopolis.xyz/api/admin//profile"),
          headers: await CustomHttpRrequest.getHeaderWithToken());

      setState(() {
        alldata = jsonDecode(response.body);
      });

      print("ttttttttttttttttttttttttttttt${alldata["name"]}");
    } catch (e) {
      print("eeeeeeeeeeeeeeeettttt${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final allprofile = Provider.of<ProfileProvider>(context).profileallUserListData;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body:allprofile.isEmpty?spinkit: Card(
          elevation: 5,
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 55,
                    backgroundImage: NetworkImage(
                        "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("Name : ${alldata["name"]}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("${alldata["email"]}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("${alldata["contact"]}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                      "Area:${alldata["billing_address"]["area"]} House:${alldata["billing_address"]["house"]}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                      child: allprofile.isEmpty?spinkit: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: allprofile.length,
                        itemBuilder:

                            (context, index) => Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(child: Text("${allprofile[index].id}"),),
                                    title: Text("${allprofile[index].name}"),
                                  )
                                ],
                              ),
                            )),
                  ))
                ],
              )),
        ));
  }
}
