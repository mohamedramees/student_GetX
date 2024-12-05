import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    super.key,
    required this.nameEntry,
    required this.fieldicon,
  });

  final String nameEntry;
  final IconData fieldicon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: 350,
        decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                fieldicon,
                color: Colors.white,
                size: 35,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(nameEntry,
                style: const TextStyle(
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }
}
