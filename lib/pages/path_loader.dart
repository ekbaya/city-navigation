import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/pages/path_request.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PathLoader extends StatefulWidget {
  const PathLoader({super.key, required this.pathRequest});
  final PathRequest pathRequest;

  @override
  State<PathLoader> createState() => _PathLoaderState();
}

class _PathLoaderState extends State<PathLoader> {
  @override
  void initState() {
    calculatePath();
    super.initState();
  }

  calculatePath() async {
    final pathResult = await NavigationController.findPath(widget.pathRequest);
    print("RESULTS======================");
    print(pathResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Getting route...",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Lottie.asset('assets/jsons/loading.json'),
    );
  }
}
