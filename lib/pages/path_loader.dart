import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/pages/path.dart';
import 'package:city_navigation/pages/path_request.dart';
import 'package:city_navigation/utilities/toastDialog.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print("RESULTS======================");
      print(pathResult.path.length);
    }
    if (pathResult.path.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PathPage(
            path: pathResult,
            pathRequest: widget.pathRequest,
          ),
        ),
      );
    } else {
      ToastDialogue()
          .showToast("Failed to calculate path. Check and try again", 1);
    }
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
