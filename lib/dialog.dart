import 'package:flutter/material.dart';

class DialogeShow extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  DialogeShow(this.title, this.callback, this.content,
      [this.actionText = " Reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          onPressed: callback,
          color: Colors.white,
          child: Text(actionText),
        )
      ],
    );
  }
}
