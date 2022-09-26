import 'package:city_navigation/controllers/navigationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController =
        Provider.of<NavigationController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Search Page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: navigationController.trips.length,
        itemBuilder: (context, index) {
          final trip = navigationController.trips[index];

          return ListTile(
            title: Text(trip.route.description),
            subtitle: Text(trip.route.short_name.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Search routes',
      //   onPressed: () => showSearch(
      //     context: context,
      //     delegate: SearchPage(
      //       onQueryUpdate: print,
      //       items: navigationController.trips,
      //       searchLabel: 'Search routes',
      //       suggestion: const Center(
      //         child: Text('Filter routes by name, short nsme or by trip name'),
      //       ),
      //       failure: const Center(
      //         child: Text('No route found :('),
      //       ),
      //       filter: (trip) => [
      //         trip!.route.description,
      //         trip.route.short_name.toString(),
      //       ],
      //       sort: (a, b) => a!.compareTo(b),
      //       builder: (trip) => ListTile(
      //         title: Text(trip!.route.description),
      //         subtitle: Text(trip.route.short_name.toString()),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //       ),
      //     ),
      //   ),
      //   child: const Icon(Icons.search),
      // ),
    );
  }
}
