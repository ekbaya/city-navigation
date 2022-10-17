import 'package:city_navigation/controllers/navigationController.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  NavigationController navigationController = NavigationController();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await navigationController.getTrips();
    await navigationController.getStops();

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/jsons/loading.json'),
      ),
    );
  }
}
