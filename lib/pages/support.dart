import 'package:city_navigation/helpers/Helper.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: const Text(
          "Support",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2.5,
            margin: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Support available 24/7, But sometimes you have to wait a bit longer",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Image.asset("assets/images/help.png"),
          const SizedBox(
            height: 40,
          ),
          Card(
            elevation: 2.5,
            margin: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Chat with our Support"),
                    trailing: IconButton(
                      onPressed: () {
                        Helper.launchWhatsApp("0769728089");
                      },
                      icon: const Icon(
                        Icons.chat,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: const Text("Call us"),
                    trailing: IconButton(
                      onPressed: () {
                        Helper.makingPhoneCall("0769728089");
                      },
                      icon: const Icon(
                        Icons.call,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: const Text("Mail us"),
                    trailing: IconButton(
                      onPressed: () {
                        Helper.launchEmail("owirakeith57@gmail.com");
                      },
                      icon: const Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
