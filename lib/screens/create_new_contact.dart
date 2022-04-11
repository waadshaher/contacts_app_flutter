import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:vimigo_technical_assessment/model/user.dart';
import 'package:vimigo_technical_assessment/services/http_service.dart';
import 'package:vimigo_technical_assessment/widgets/constants.dart';

import '../widgets/text_form_fields.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              MyTextFormField(
                  savedValues: _saveName,
                  isName: true,
                  myHintText: "What is the contact's name?",
                  myLabelText: "Full Name"),
              const SizedBox(
                height: 20,
              ),
              MyTextFormField(
                savedValues: _savePhone,
                isName: false,
                myHintText: "What is the contact's phone number?",
                myLabelText: "Phone Number",
              ),
              const SizedBox(
                height: 20,
              ),
              DatePicker(savedValues: _saveDate),
              const SizedBox(
                height: 20,
              ),
              TimePicker(
                savedValues: _saveTime,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        label: _isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Row(
                children: const [Icon(Icons.save), Text('Save')],
              ),
        onPressed: _isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  DateTime combinedDateTime =
                      DateTimeField.combine(selectedDate, selectedTime);
                  User newUser = User(
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
                        label: 'Okay',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateContact(),
                        ));
                  }
                }
              },
      ),
    );
  }

  _saveName(String value) {
    setState(() {
      _name = value;
    });
  }

  _savePhone(String value) {
    setState(() {
      _phoneNumber = value;
    });
  }

  _saveDate(DateTime value) {
    setState(() {
      selectedDate = value;
    });
  }

  _saveTime(DateTime value) {
    setState(() {
      selectedTime = TimeOfDay.fromDateTime(value);
    });
  }
}

class DatePicker extends StatelessWidget {
  final String date = 'Pick a date';
  final format = DateFormat('d MMM yyyy');
  late final DateTime selectedDate;
  final Function savedValues;
  DatePicker({Key? key, required this.savedValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        format: format,
        onShowPicker: (context, currentValue) async {
          return await showRoundedDatePicker(
              context: context, initialDate: currentValue ?? DateTime.now());
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
          savedValues(value);
        },
        decoration: myDecorator("Check-in date"));
  }
}

class TimePicker extends StatelessWidget {
  final String date = 'Pick a date';
  final format = DateFormat('hh:mm a');
  final Function savedValues;

  TimePicker({Key? key, required this.savedValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          savedValues(value);
        },
        decoration: myDecorator("Check-in time"));
  }
}
