import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
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
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.pink,
                  decoration: InputDecoration(
                    hintText: "What is the contact's name?",
                    labelText: "Full Name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade300),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pink)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.pink,
                  decoration: InputDecoration(
                    hintText: "What is the contact's phone number?",
                    labelText: "Phone Number",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade300),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pink)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              DatePicker(),
              SizedBox(
                height: 20,
              ),
              TimePicker(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        label: Row(
          children: [Icon(Icons.save), Text('Save')],
        ),
        onPressed: () {
          Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => CreateContact(),
              ));
        },
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  String date = 'Pick a date';
  final format = DateFormat('d MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          return await showRoundedDatePicker(
              context: context, initialDate: currentValue ?? DateTime.now());
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.pink.shade400,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          labelText: "Check-in date",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.pink.shade300),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pink)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink),
          ),
        ));
  }
}

class TimePicker extends StatelessWidget {
  String date = 'Pick a date';
  final format = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showRoundedTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          return DateTimeField.convert(time);
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.pink.shade400,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          labelText: "Check-in time",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.pink.shade300),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pink)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pink),
          ),
        ));
  }
}
