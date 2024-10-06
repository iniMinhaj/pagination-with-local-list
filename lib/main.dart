import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaginatedListView(),
    );
  }
}

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({super.key});

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final List<String> _allItems = List.generate(50, (index) => 'Item $index');
  final List<String> _displayedItems = [];
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 13;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();

    // Listen for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() {
    if (_currentPage * _itemsPerPage < _allItems.length) {
      setState(() {
        // Calculate the range of items to be added
        int start = _currentPage * _itemsPerPage;
        int end = start + _itemsPerPage;
        print("current page = $_currentPage");
        print("start - $start");
        print("end - $end");
        print("all item = ${_allItems.length}");
        if (end > _allItems.length) {
          end = _allItems.length;
          print("final end = $end");
        }

        // Add items to the displayed list
        _displayedItems.addAll(_allItems.sublist(start, end));
        _currentPage++;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated ListView')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _displayedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_displayedItems[index]),
          );
        },
      ),
    );
  }
}
