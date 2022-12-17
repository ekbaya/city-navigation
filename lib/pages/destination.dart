import 'package:city_navigation/pages/path_loader.dart';
import 'package:city_navigation/pages/path_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/navigationController.dart';
import '../models/Node.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key, required this.origin});

  final String origin;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  late SearchBar searchBar;
  _DestinationPageState() {
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
        "Pick your destination",
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
                  PathRequest pathRequest = PathRequest(
                      location: widget.origin, destination: item.name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PathLoader(
                        pathRequest: pathRequest,
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
