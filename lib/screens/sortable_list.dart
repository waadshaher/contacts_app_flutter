import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:vimigo_technical_assessment/model/user.dart';
import 'package:flutter/material.dart';
import 'package:vimigo_technical_assessment/screens/contact_detail.dart';
import 'package:vimigo_technical_assessment/services/http_service.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'create_new_contact.dart';

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
  List<User> usersFiltered = [];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBarText = const Text('Contacts Dataset');
  final searchController = TextEditingController();
  final formatDate = DateFormat('d MMM yyyy hh:mm a');
  bool hasSearched = false;
  var fetchedCoin;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterValues);
  }

  void _filterValues() {
    var searchVal = searchController.text.toLowerCase();
    setState(() {
      usersFiltered = users
          .where((element) =>
              element.name.toLowerCase().contains(searchVal) ||
              element.phoneNumber.toLowerCase().contains(searchVal) ||
              formatDate
                  .format(element.checkIn)
                  .toLowerCase()
                  .contains(searchVal))
          .toList();
      hasSearched = searchVal.isNotEmpty;
    });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
              colors: [Colors.blue, Colors.green],
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
                  customSearchBarText = ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  usersFiltered = users;
                  searchController.text = "";
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'uniqueTag',
            hoverElevation: 50,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateContact(),
                  )).then((onGoBack));
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
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.green])),
            ),
          ),
          SizedBox(
            width: 90,
          ),
          getCoin()
        ],
      ),
    );
  }

  FutureBuilder getCoin() {
    var spriteSheet = Flame.images.load('animation_spritesheet.png');
    return FutureBuilder(
      future: spriteSheet,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          fetchedCoin = snapshot.data ?? [];
          return Container(
            height: 100,
            width: 100,
            child: SpriteAnimationWidget(
                animation: SpriteSheet.fromColumnsAndRows(
                        image: fetchedCoin, columns: 12, rows: 3)
                    .createAnimation(
                        from: 0, to: 35, stepTime: 0.06, row: 0, loop: true)),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Container();
      },
    );
  }

  FutureBuilder<List<User>> getContacts() {
    futureUsers = dataService.getUsers();
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
        rows: getRows(users));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<User> users) {
    List<User> currentUsersList = [];
    if (!hasSearched) {
      currentUsersList = users;
    } else {
      currentUsersList = usersFiltered;
    }
    return currentUsersList.map((User user) {
      DateTime time = user.checkIn;
      String formattedDate = formatDate.format(time);
      final cells = [user.name, user.phoneNumber, formattedDate];
      return DataRow(
          cells: getCells(cells),
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailView(
                    userData: user,
                    checkIn: formattedDate,
                  ),
                ));
          });
    }).toList();
  }

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
