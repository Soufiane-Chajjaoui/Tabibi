import 'package:flutter/material.dart';

class snackbar extends StatelessWidget {
  const snackbar({super.key , required this.resultMessage});
  final String? resultMessage;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.cyan[300],
      content:   Text(
        '${resultMessage}',
        style: TextStyle(
            color: Color.fromARGB(255, 88, 63, 112),
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins'),
      ),
      duration: const Duration(milliseconds: 3000),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.all(15 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
