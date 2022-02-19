import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter_project/features/apod/presentation/bloc/apod_bloc.dart';
import 'package:flutter_project/features/apod/presentation/components/button_pick_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String? dateNow;

  const DatePicker({Key? key, required this.dateNow}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState(dateNow);
}

class _DatePickerWidgetState extends State<DatePicker> {
  late DateTime date;

  _DatePickerWidgetState(String? dateNow) {
    if (dateNow != null) {
      date = DateFormat('yyyy-MM-dd').parse(dateNow);
    } else {
      date = DateTime.now();
    }
  }

  String getText() {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) => ButtonPickDate(
    title: 'Select date',
    text: getText(),
    onClicked: () => pickDate(context),
  );

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;

    setState(() => date = newDate);

    final formatter = DateFormat('yyyy-MM-dd');
    final param = formatter.format(newDate);

    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.loadApod(param);
  }
}