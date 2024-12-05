import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_id_getx/controller/student_getx_functions.dart';
import 'package:student_id_getx/model/student_model.dart';
import 'package:student_id_getx/widgets/custom_textfield.dart';

class EditStudent extends StatelessWidget {
  final Student nameEntry;
  final int index;

  EditStudent({super.key, required this.nameEntry, required this.index});

  final StudentController studentController = Get.find<StudentController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with existing data
    nameController.text = nameEntry.name;
    placeController.text = nameEntry.place;
    ageController.text = nameEntry.age.toString();
    phoneController.text = nameEntry.phoneNumber;
    studentController.selectedImage.value = nameEntry.imageUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${nameEntry.name}"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.blue,
                        child: ClipOval(
                          child: studentController.selectedImage.value!.isNotEmpty
                              ? Image.file(
                                  File(studentController.selectedImage.toString()),
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Choose Image"),
                            actions: [
                              InkWell(
                                onTap: () {
                                  studentController.pickImage(ImageSource.gallery);
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Gallery"),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  studentController.pickImage(ImageSource.camera);
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Camera"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.lightGreenAccent,
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CustomTextfield(
                      keyboardtype: TextInputType.text,
                      controller: nameController,
                      labelText: 'Enter Name',
                      prefixIcon: const Icon(Icons.person_2_rounded),
                    ),
                    const SizedBox(height: 30),
                    CustomTextfield(
                      keyboardtype: TextInputType.text,
                      controller: placeController,
                      labelText: 'Place',
                      prefixIcon: const Icon(Icons.place),
                    ),
                    const SizedBox(height: 30),
                    CustomTextfield(
                      keyboardtype: TextInputType.number,
                      controller: ageController,
                      labelText: 'Age',
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    const SizedBox(height: 30),
                    CustomTextfield(
                      keyboardtype: TextInputType.number,
                      controller: phoneController,
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        final name = nameController.text.trim();
                        final age = int.tryParse(ageController.text.trim()) ?? 0;
                        final place = placeController.text.trim();
                        final phoneNumber = phoneController.text.trim();

                        if (name.isNotEmpty && place.isNotEmpty && phoneNumber.isNotEmpty) {
                          studentController.updateStudent(
                            index,
                            name,
                            place,
                            age,
                            studentController.selectedImage.toString()
                            ,
                            phoneNumber,
                          );
                          Get.back(); // Navigate back
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightGreenAccent, Colors.lightBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: const Center(
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
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
