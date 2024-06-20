import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'team.dart';

class TeamForm extends StatefulWidget {
  final Team? team;

  TeamForm({this.team});

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  final _formKey = GlobalKey<FormState>();
  late int _id;
  late String _name;
  late int _year;
  late DateTime _dateChamp;

  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.team != null) {
      _id = widget.team!.id;
      _name = widget.team!.name;
      _year = widget.team!.year;
      _dateChamp = widget.team!.dateChamp;
      _dateController.text = DateFormat('yyyy-MM-dd').format(_dateChamp);
    } else {
      _id = 0;
      _name = '';
      _year = 0;
      _dateChamp = DateTime.now();
      _dateController.text = DateFormat('yyyy-MM-dd').format(_dateChamp);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateChamp,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dateChamp)
      setState(() {
        _dateChamp = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_dateChamp);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team == null ? 'Add Team' : 'Edit Team'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.team?.id.toString() ?? '',
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _id = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.team?.name ?? '',
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: widget.team?.year.toString() ?? '',
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter year';
                  }
                  return null;
                },
                onSaved: (value) {
                  _year = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date Champ',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date champ';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dateChamp = DateFormat('yyyy-MM-dd').parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      Team(id: _id, name: _name, year: _year, dateChamp: _dateChamp),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
