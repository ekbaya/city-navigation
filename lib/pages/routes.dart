import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/helpers/Helper.dart';
import 'package:city_navigation/models/Trip.dart';
import 'package:city_navigation/pages/directions.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  static const _pageSize = 20;
  int page = 0;

  final PagingController<int, Trip> _pagingController =
      PagingController(firstPageKey: 1);

  final NavigationController navigationController = NavigationController();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      page = page + 1;
      _fetchPage(page);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    print("Called with page $pageKey");
    try {
      final newItems =
          await navigationController.getPaginatedTrips(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Routes to and from the City",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PagedListView<int, Trip>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Trip>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(isNumberOdd(index)
                ? reverseString(item.route.description)
                : item.route.description),
            subtitle: Text(item.trip_id),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DirectionsPage(
                        name: item.route.long_name,
                        lat: item.shape.shape_pt_lat,
                        long: item.shape.shape_pt_lon,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.directions,
                  size: 30,
                  color: Colors.indigo,
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  String reverseString(str) {
    return str.split('-').reversed.join('-');
  }

  bool isNumberOdd(int index) {
    return index.isOdd;
  }
}
