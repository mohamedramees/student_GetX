import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_id_getx/model/student_model.dart';
import 'package:student_id_getx/widgets/custom_field.dart';

class ProfileScreen extends StatelessWidget {
  final Student nameEntry;

  // Receive `nameEntry` via Get.arguments
  const ProfileScreen({super.key, required this.nameEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${nameEntry.name}'s Profile",
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              if (nameEntry.imageUrl.isNotEmpty)
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: Image.file(
                        File(nameEntry.imageUrl),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nameEntry.name,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      nameEntry: nameEntry.place,
                      fieldicon: Icons.place,
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      nameEntry: nameEntry.age.toString(),
                      fieldicon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 20),
                    CustomTextBox(
                      nameEntry: nameEntry.phoneNumber,
                      fieldicon: Icons.phone,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
