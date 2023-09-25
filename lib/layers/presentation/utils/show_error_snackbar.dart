import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(255, 210, 0, 0),
    duration: const Duration(seconds: 5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    content: Text(
      "ATENÇÃO: $errorMessage",
      textScaleFactor: 1,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
