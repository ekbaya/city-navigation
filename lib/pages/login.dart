import 'package:city_navigation/controllers/authController.dart';
import 'package:city_navigation/models/LoginDTO.dart';
import 'package:city_navigation/models/LoginResponse.dart';
import 'package:city_navigation/pages/home.dart';
import 'package:city_navigation/utilities/toastDialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/AppStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool loading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Sign In",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  "Welcome",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
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
                      GestureDetector(
                        onTap: () async {
                          if (validateData()) {
                            setState(() {
                              loading = true;
                            });
                            LoginDTO loginDTO = LoginDTO(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());

                            final LoginResponse loginResponse =
                                await AuthController.loginUser(loginDTO);

                            setState(() {
                              loading = false;
                            });

                            if (loginResponse.success) {
                              //store the token
                              SharedPreferences prefes =
                                  await SharedPreferences.getInstance();
                              prefes.setString("token", loginResponse.token);
                              ToastDialogue()
                                  .showToast(loginResponse.message, 0);
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            } else {
                              ToastDialogue()
                                  .showToast(loginResponse.message, 1);
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
                                    "SIGN IN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password?")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateData() {
    if (emailController.text.isEmpty) {
      ToastDialogue().showToast("Email is required", 1);
      return false;
    } else if (passwordController.text.isEmpty) {
      ToastDialogue().showToast("Password is required", 1);
      return false;
    } else {
      return true;
    }
  }
}
