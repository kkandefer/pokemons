import 'dart:ui';
import 'package:flutter/material.dart';

class PkErrorWidget extends StatelessWidget {

  final String message;
  final VoidCallback? callback;

  const PkErrorWidget({Key? key, required this.message, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(message,
              textAlign: TextAlign.center,
            ),
          ),
          if(callback != null)
            MaterialButton(
              child: Text("Spróbuj ponownie",
              ),
              onPressed: callback,
            )
        ],
      ),
    );
  }
}
