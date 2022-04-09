import 'package:vimigo_technical_assessment/model/user.dart';
import 'package:flutter/material.dart';
import 'package:vimigo_technical_assessment/screens/contact_detail.dart';
import 'package:vimigo_technical_assessment/services/http_service.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';

import 'screens/create_new_contact.dart';

class SortablePage extends StatefulWidget {
  @override
  _SortablePageState createState() => _SortablePageState();
}

const List<Color> _loadingIndicatorRainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class _SortablePageState extends State<SortablePage> {
  late Future<List<User>> futureUsers;
  int? sortColumnIndex;
  bool isAscending = false;
  List<User> users = [];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBarText = const Text('Contacts Dataset');

  @override
  void initState() {
    super.initState();
    futureUsers = dataService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBarText,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.purple],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBarText = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBarText = const Text('Contacts Dataset');
                  }
                });
              },
              icon: customIcon,
            )
          ],
        ),
        body: getContacts(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'uniqueTag',
          hoverElevation: 50,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateContact(),
                ));
          },
          child: Container(
            width: 60,
            height: 60,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.red, Colors.purple])),
          ),
        ));
  }

  FutureBuilder<List<User>> getContacts() {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          users = snapshot.data ?? [];
          return SingleChildScrollView(child: buildDataTable());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: _loadingIndicatorRainbowColors,
            strokeWidth: 0.5,
          ),
        );
      },
    );
  }

  Widget buildDataTable() {
    final columns = ['Name', 'Phone', 'Check in'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(users),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<User> users) => users.map((User user) {
        DateTime time = user.checkIn;
        String formattedDate = DateFormat('d MMM yyyy hh:mm a').format(time);
        final cells = [user.name, user.phoneNumber, formattedDate];
        return DataRow(
            cells: getCells(cells),
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailView(
                      userData: user,
                    ),
                  ));
            });
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      users.sort(
          (user1, user2) => compareValues(ascending, user1.name, user2.name));
    } else if (columnIndex == 1) {
      users.sort((user1, user2) =>
          compareValues(ascending, user1.phoneNumber, user2.phoneNumber));
    } else if (columnIndex == 2) {
      users.sort((user1, user2) =>
          compareValues(ascending, user1.checkIn, user2.checkIn));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareValues<T extends Comparable>(bool ascending, T value1, T value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }
}
