import 'package:eydev_qr_scanner_and_generator/src/data/DBConnection.dart';
import 'package:eydev_qr_scanner_and_generator/src/widgets/ScanList.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  DataSearch()
      : super(
          searchFieldLabel: 'Buscar scans',
          keyboardType: TextInputType.text,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(future: DBConnection.db.searchScans(query), builder: _notesResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(future: DBConnection.db.searchScans(query), builder: _notesResult);
  }

  Widget _notesResult(BuildContext context, AsyncSnapshot snapshot) => ScanList(snapshot: snapshot);
}
