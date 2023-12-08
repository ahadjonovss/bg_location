import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<List> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List times = prefs.getStringList('times') ?? [];
    final List statuses = prefs.getStringList('statuses') ?? [];
    List sTimes = times.reversed.toList();
    List sStasuses = statuses.reversed.toList();

    if (times != null) {
      setState(() {
        _items = [sTimes, sStasuses];
      });
    }
    print(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _loadItems();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent.withOpacity(0.1),
        title: const Text('History', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount:
            _items.isNotEmpty && _items[0].isNotEmpty && _items[1].isNotEmpty
                ? _items[1].length
                : 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
            title: Text(
              _items[0][index],
              style: TextStyle(
                  color: _items[1][index] == "200" ? Colors.green : Colors.red),
            ),
            subtitle: Text(
              _items[1][index],
              style: TextStyle(color: Colors.white.withOpacity(0.3)),
            ),
          );
        },
      ),
    );
  }
}
