import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/peovider/catagory_provider.dart';
import 'package:real_api/scrren/cont/common_data.dart';
import 'package:real_api/scrren/cont/wiget.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // Provider.of<CatagoryProvider>(context, listen: false).getCatagoryList();
    super.initState();
  }

  bool isLoading = false;

  valeditionData() {
    if (nameController.text.isEmpty) {
      showTost("Enter Name");
    } else {
      uploadProduct();
    }
  }

  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });

      String uriLink = "${baseUrl}category/store";

      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRrequest.getHeaderWithToken());

      request.fields["name"] = nameController.text.toString();

      var photo = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(photo);
      var photo_icon = await http.MultipartFile.fromPath("icon", imageicon!.path);
      request.files.add(photo_icon);
      var responce = await request.send();

      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
       print(
           "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");

      if (responce.statusCode == 201) {
        showTost("Product Uploaded Succesfully");

        Navigator.of(context).pop();
      } else {
        showTost("Something wrong, try again plz bro");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final weidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Prodact Admin"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: image == null
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    getImageformGallery();
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.teal,
                                        size: 60,
                                      ),
                                      Text(
                                        "UPLOAD Image",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.teal.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(image!),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: weidth * 0.4,
                        child: Visibility(
                          // visible: isImageVisiable,
                          child: TextButton(
                            onPressed: () {
                              getImageformGallery();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.black,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                              child: Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: imageicon == null
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    getImageformGalleryIcon();
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_album,
                                        color: Colors.teal,
                                        size: 60,
                                      ),
                                      Text(
                                        "UPLOAD Icon",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.teal.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(imageicon!),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: weidth * 0.4,
                        child: Visibility(
                          // visible: isImageVisiable,
                          child: TextButton(
                            onPressed: () {
                              getImageformGalleryIcon();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.black,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5)),
                              child: Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    Controller: nameController,
                    labelText: "Enter product Name",
                    icon: Icons.abc,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        valeditionData();
                        //uploadProduct();
                      },
                      child: Text("Add Prodact"))
                ],
              ),
            )),
      ),
    );
  }

  File? image;
  final picker = ImagePicker();

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('${image!.path}');
      } else {
        print('no image found');
      }
    });
  }

File? imageicon;
  final picker_icon = ImagePicker();

  Future getImageformGalleryIcon() async {
    print('on the way of gallery');
    final pickedImage_icon = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage_icon != null) {
        imageicon = File(pickedImage_icon.path);
        print('image found');
        print('${imageicon!.path}');
      } else {
        print('no image found');
      }
    });
  }
}
