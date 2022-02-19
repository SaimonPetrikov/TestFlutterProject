import 'package:flutter/material.dart';

class ButtonPickDate extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonPickDate({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    title: title,
    child: ButtonWidget(
      text: text,
      onClicked: onClicked,
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
    ),
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    ),
    onPressed: onClicked,
  );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );
}
