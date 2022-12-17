import 'package:city_navigation/controllers/navigationController.dart';
import 'package:city_navigation/models/Node.dart';
import 'package:city_navigation/pages/destination.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late SearchBar searchBar;
  _LocationPageState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: (keyword) {
          searchTrips(1, keyword);
        },
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        "Pick your origin point",
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        searchBar.getSearchAction(context),
      ],
    );
  }

  static const _pageSize = 20;
  int page = 0;

  final PagingController<int, Node> _pagingController =
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
    if (kDebugMode) {
      print("Called with page $pageKey");
    }
    try {
      final newItems =
          await navigationController.getPaginatedNodes(pageKey, _pageSize);
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

  Future<void> searchTrips(int pageKey, String keyword) async {
    try {
      final newItems =
          await navigationController.searchNodes(pageKey, _pageSize, keyword);

      _pagingController.refresh();
      final nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: PagedListView<int, Node>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Node>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.name),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinationPage(
                        origin: item.name,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.place,
                  size: 30,
                  color: Colors.indigo,
                )),
          ),
        ),
      ),
    );
  }
}
