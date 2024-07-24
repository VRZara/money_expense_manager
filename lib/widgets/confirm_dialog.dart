import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, String title, String content) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[850],
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        content,
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red,
            ),
          ),
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.grey[700],
            ),
          ),
          child: Text(
            "No",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
