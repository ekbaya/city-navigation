import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/helpers/Helper.dart';
import 'package:city_navigation/models/Stop.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BusStopsPage extends StatefulWidget {
  const BusStopsPage({super.key});

  @override
  State<BusStopsPage> createState() => _BusStopsPageState();
}

class _BusStopsPageState extends State<BusStopsPage> {
  static const _pageSize = 20;
  int page = 0;

  final PagingController<int, Stop> _pagingController =
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
          await navigationController.getPaginatedStops(pageKey, _pageSize);
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
          "Stops To and From Town",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PagedListView<int, Stop>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Stop>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.stop_name),
            subtitle: Text(item.stop_id),
            trailing: IconButton(
              onPressed: () {
                Helper.openMap(
                    double.parse(item.stop_lat), double.parse(item.stop_lon));
              },
              icon: const Icon(
                Icons.directions,
                size: 30,
                color: Colors.indigo,
              ),
            ),
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
