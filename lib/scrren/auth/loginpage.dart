import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:real_api/scrren/bottom_nav.dart';
import 'package:real_api/scrren/cont/common_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  var baseUrl = "https://apihomechef.antopolis.xyz/api/admin/";

  login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        isLoading = true;
      });
      var link = "https://apihomechef.antopolis.xyz/api/admin/sign-in";
      var map = Map<String, dynamic>();
      map["email"] = _email.text.toString();
      map["password"] = _password.text.toString();
      var recsponce = await http.post(Uri.parse(link), body: map);
      //print("aaaaaaaaa${recsponce.body}");
      setState(() {
        isLoading = false;
      });
      var data = jsonDecode(recsponce.body);
      if(data['access_token']!=null){
        sharedPreferences.setString("token", data["access_token"]);
      //  print("shhhhhhhh${sharedPreferences.getString("token")}");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNav()),
                (route) => false);
      }else{
        showTost("Email or password doesnt match");

      }



    //  print("rrrrrrrrrrrrrrrrrrrrrr${data["access_token"]}");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showTost(e.toString());
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      opacity: 0.5,
      blur: 0.5,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width / 0.5,
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Sign In to Contiue!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "email", Icons.account_box, _email),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(size, "password", Icons.lock, _password),
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              customButton(size),
              SizedBox(
                height: size.height / 40,
              ),
              GestureDetector(
                // onTap: () => Navigator.of(context).push(
                //     MaterialPageRoute(builder: (_) => CreateAccount())),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            login();
          });
        } else {
          print("Please fill form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
