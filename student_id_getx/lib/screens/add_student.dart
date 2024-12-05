import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_id_getx/controller/student_getx_functions.dart';
import 'package:student_id_getx/widgets/custom_button.dart';
import 'package:student_id_getx/widgets/custom_textfield.dart';
import 'package:student_id_getx/widgets/profile_image.dart';

class AddStudent extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the StudentController
    final studentController = Get.find<StudentController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Student',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Obx(() => CustomProfileAvatar(
                      imagePath: studentController.selectedImage.value,
                      cirlebackground: Colors.lightGreenAccent,
                      backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
                      onTapGalleryTap: () {
                        studentController.pickImage(ImageSource.gallery);
                      },
                      onCameraTap: () {
                        studentController.pickImage(ImageSource.camera);
                      },
                    )),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextfield(
                          controller: nameController,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          keyboardtype: TextInputType.text,
                          labelText: 'Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextfield(
                          controller: placeController,
                          prefixIcon: const Icon(
                            Icons.place,
                            color: Colors.white,
                          ),
                          keyboardtype: TextInputType.text,
                          labelText: 'Place'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextfield(
                          controller: ageController,
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          keyboardtype: TextInputType.number,
                          labelText: 'Age'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextfield(
                          controller: phoneController,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          keyboardtype: TextInputType.number,
                          labelText: 'Phone'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final place = placeController.text;
                      final age = int.tryParse(ageController.text) ?? 0;
                      final phoneNumber = phoneController.text;

                      if (name.isNotEmpty &&
                          place.isNotEmpty &&
                          phoneNumber.isNotEmpty &&
                          studentController.selectedImage.value != null) {
                        studentController.addStudent(
                          name,
                          age,
                          place,
                          phoneNumber,
                          studentController.selectedImage.value!,
                        );

                        // Clear input fields
                        nameController.clear();
                        placeController.clear();
                        ageController.clear();
                        phoneController.clear();
                        studentController.clearSelectedImage();
                        Get.back();
                      }
                    }
                  },
                  gradientColors: const [
                    Colors.lightGreenAccent,
                    Colors.lightBlue,
                  ],
                  boxShadowColor: Colors.transparent,
                  buttonText: 'SAVE',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
