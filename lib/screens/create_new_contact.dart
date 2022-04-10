import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vimigo_technical_assessment/model/user.dart';
import 'package:vimigo_technical_assessment/services/http_service.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  bool _isLoading = false;
  final dateFormat = DateFormat('d MMM yyyy');
  final timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add New Contact"),
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
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is a required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "What is the contact's name?",
                    labelText: "Full Name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightBlue)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is a required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _phoneNumber = value!;
                    });
                  },
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "What is the contact's phone number?",
                    labelText: "Phone Number",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightBlue)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              DateTimeField(
                  format: dateFormat,
                  onShowPicker: (context, currentValue) async {
                    return await showRoundedDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now());
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.blue,
                  validator: (value) {
                    if (value == null) {
                      return 'This is a required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedDate = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Check-in date",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightBlue)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              DateTimeField(
                  format: timeFormat,
                  onShowPicker: (context, currentValue) async {
                    final time = await showRoundedTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    return DateTimeField.convert(time);
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.blue,
                  validator: (value) {
                    if (value == null) {
                      return 'This is a required field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedTime = TimeOfDay.fromDateTime(value!);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Check-in time",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.lightBlue)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        label: _isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Row(
                children: [Icon(Icons.save), Text('Save')],
              ),
        onPressed: _isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  DateTime combinedDateTime =
                      DateTimeField.combine(_selectedDate, _selectedTime);
                  User newUser = new User(
                    name: _name,
                    phoneNumber: _phoneNumber,
                    checkIn: combinedDateTime,
                  );
                  setState(() {
                    _isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  final result = await dataService.addUser(newUser);
                  setState(() {
                    _isLoading = false;
                  });
                  if (result) {
                    final snackBar = SnackBar(
                      content: const Text('New contact is added'),
                      duration: const Duration(seconds: 30),
                      action: SnackBarAction(
                        label: 'Thanks!',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateContact(),
                        ));
                  }
                }
              },
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String date = 'Pick a date';
  final format = DateFormat('d MMM yyyy');
  late DateTime selectedDate;

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
        onSaved: (value) {
          setState(() {
            selectedDate = value!;
          });
        },
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
