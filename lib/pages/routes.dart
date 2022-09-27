import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/models/Trip.dart';
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
          "Routes",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PagedListView<int, Trip>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Trip>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.route.description),
            subtitle: Text(item.trip_id),
            trailing: const Icon(Icons.arrow_forward_ios),
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
}
