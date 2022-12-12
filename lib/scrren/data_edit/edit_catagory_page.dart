import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:real_api/custom_http_reqest/custom_http_request.dart';
import 'package:real_api/model/CatagoryModel.dart';
import 'package:real_api/model/ProdactModel.dart';
import 'package:real_api/scrren/cont/common_data.dart';

class EditCatagoryPage extends StatefulWidget {
  CatagoryModel? catagoryModel;

  EditCatagoryPage({Key? key, required this.catagoryModel}) : super(key: key);

  @override
  State<EditCatagoryPage> createState() => _EditCatagoryPageState();
}

class _EditCatagoryPageState extends State<EditCatagoryPage> {
  TextEditingController? nameController;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.catagoryModel!.name);
    super.initState();
  }

  bool isLoading = false;

  updateProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      showTost("Uploading");
      var uriLink = "${baseUrl}category/${widget.catagoryModel!.id}/update";
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(uriLink),
      );
      request.headers.addAll(await CustomHttpRrequest.getHeaderWithToken());
      request.fields["name"] = nameController!.text.toString();
      request.fields["category_id"] =
          widget.catagoryModel!.id.toString();
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath("image", image!.path));
      }if (imageicon != null) {
        request.files
            .add(await http.MultipartFile.fromPath("icon", imageicon!.path));
      }
      var responce = await request.send();
      setState(() {
        isLoading = false;
      });
      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      print(
          "Status code issssssssssssssss${responce.statusCode} ${responceString}");
      if (responce.statusCode == 200) {
        showTost("Product Uploaded succesfully");
        Navigator.of(context).pop();
      } else {
        showTost("Something Wrong");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showTost("Something wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        blur: 0.5,
        opacity: 0.5,
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [SizedBox(
                  height: 30,
                ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Enter Product Name"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: image == null
                            ? InkWell(
                                onTap: () {
                                  getImageformGallery();
                                },
                                child: Image.network(
                                    "${imageUrl}${widget.catagoryModel!.image}"))
                            : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(image!),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
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
                    ],
                  ),SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: imageicon == null
                            ? InkWell(
                                onTap: () {
                                  getImageformGallery();
                                },
                                child: Image.network(
                                    "${imageUrl}${widget.catagoryModel!.icon}"))
                            : Container(
                                height: 150,
                                width: 200,
                                child: Image.file(imageicon!),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
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
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    color: Colors.teal,
                    onPressed: () {
                      updateProduct();
                      //   uploadProduct();
                    },
                    child: Text("Upload Productt"),
                  )
                ],
              ),
            ),
          ),
        ),
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
  } File? imageicon;
  final pickericon = ImagePicker();

  Future getImageformGalleryIcon() async {
    print('on the way of gallery');
    final pickedImageicon = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImageicon != null) {
        image = File(pickedImageicon.path);
        print('image found');
        print('${image!.path}');
      } else {
        print('no image found');
      }
    });
  }
}
