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

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? categoryType;
  TextEditingController nameController = TextEditingController();
  TextEditingController orginalPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
 // TextEditingController discountTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    Provider.of<CatagoryProvider>(context, listen: false).getCatagoryList();
    super.initState();
  }

  bool isLoading = false;

  valeditionData(){
    if (nameController.text.isEmpty) {
      showTost("Enter Name");
    } else if (orginalPriceController.text.isEmpty) {
      showTost( "Enter Orginal Price");
    } else if (discountPriceController.text.isEmpty) {
      showTost( "Enter Discount Price");
    }  else if (quantityController.text.isEmpty) {
          showTost( "Enter Quantity");
    }else {

      uploadProduct();
    }
  }
  uploadProduct() async {


    if (mounted) {
      setState(() {
        isLoading = true;
      });

      String uriLink = "${baseUrl}product/store";

      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRrequest.getHeaderWithToken());

      request.fields["name"] = nameController.text.toString();
      request.fields["category_id"] = categoryType.toString();
      request.fields["quantity"] = quantityController.text.toString();
      request.fields["original_price"] = orginalPriceController.text.toString();
      request.fields["discounted_price"] =
          discountPriceController.text.toString();
      request.fields["discount_type"] = "fixed";
      var photo = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(photo);
      var responce = await request.send();

      var responceData = await responce.stream.toBytes();
      var responceString = String.fromCharCodes(responceData);
      // print("responce bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${responceString}");
      // print(
      //     "Status code issss${responce.statusCode} ${request.fields} ${request.files.toString()}");

      if (responce.statusCode == 201) {
        showTost("Product Uploaded Succesfully");

        Navigator.of(context).pop();
      } else {
        showTost("Something wrong, try again plz bro");
      }
    }
  }

  List<CatagoryModel> categoryList = [];

  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CatagoryProvider>(context).catagoryListData;
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        border: Border.all(color: Colors.grey, width: 0.2),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 50,
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 35,
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        value: categoryType,
                        hint: Text(
                          'Select Category',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryType = newValue;
                            print("my Category is $categoryType");

                            // print();
                          });
                        },
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        items: categoryList.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  "${item.name}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                value: item.id.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
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
                                        "UPLOAD",
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
                  CustomTextField(
                    Controller: nameController,
                    labelText: "Enter product Name",
                    icon: Icons.abc,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    Controller: orginalPriceController,
                    labelText: "Enter product Price",
                    icon: Icons.price_change,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    Controller: discountPriceController,
                    labelText: "Enter Discount Price",
                    icon: Icons.abc,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextField(
                    Controller: quantityController,
                    labelText: "Enter Quantity",
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
}
