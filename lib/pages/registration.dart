import 'package:city_navigation/constants/AppStyle.dart';
import 'package:city_navigation/controllers/authController.dart';
import 'package:city_navigation/models/RegistrationResponse.dart';
import 'package:city_navigation/models/UserDTO.dart';
import 'package:city_navigation/pages/login.dart';
import 'package:city_navigation/utilities/toastDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool checkedValue = false;
  bool hidePassword = true;
  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1.0,
                blurRadius: 1.0,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter Your Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Support will be using these details to identify you",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.account_box),
                            hintText: "Full name",
                            hintStyle: TextStyle(fontSize: 13),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Email Address",
                            hintStyle: TextStyle(fontSize: 13),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Phone number",
                            hintStyle: TextStyle(fontSize: 13),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword
                                        ? hidePassword = false
                                        : hidePassword = true;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 13),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Checkbox(
                                value: checkedValue,
                                onChanged: (value) {
                                  setState(() {
                                    checkedValue = value!;
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Text(
                              "I agree to the Terms & Conditions and Privacy Policy",
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (validateData()) {
                            setState(() {
                              loading = true;
                            });
                            UserDTO userDTO = UserDTO(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim());

                            final RegistrationResponse response =
                                await AuthController.registerUser(userDTO);
                            setState(() {
                              loading = false;
                            });

                            if (response.success == "true") {
                              ToastDialogue().showToast(response.message, 0);
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            } else {
                              ToastDialogue().showToast(response.message, 1);
                            }
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppStyle.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.yellow,
                                  )
                                : const Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateData() {
    if (nameController.text.isEmpty) {
      ToastDialogue().showToast("Name is required", 1);
      return false;
    } else if (emailController.text.isEmpty) {
      ToastDialogue().showToast("Email is required", 1);
      return false;
    } else if (phoneController.text.isEmpty) {
      ToastDialogue().showToast("Phone number is required", 1);
      return false;
    } else if (passwordController.text.isEmpty) {
      ToastDialogue().showToast("Password is required", 1);
      return false;
    } else if (!checkedValue) {
      ToastDialogue()
          .showToast("Please accept terms and conditions before continuing", 1);
      return false;
    } else {
      return true;
    }
  }
}
