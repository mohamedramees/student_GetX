import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_id_getx/controller/student_getx_functions.dart';
import 'package:student_id_getx/screens/add_student.dart';
import 'package:student_id_getx/screens/edit_student.dart';
import 'package:student_id_getx/screens/student_profile_card.dart';

class StudentList extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final StudentController studentController = Get.put(StudentController());

  StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.lightGreenAccent[400],
          onPressed: () {
            Get.to(() => AddStudent());
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'HOME(GetX)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: FocusNode(),
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  focusColor: Colors.white,
                  fillColor: Colors.black,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  studentController.filterStudents(value);
                },
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          final students = studentController.filteredStudents;
          return students.isEmpty
              ? const Center(
                  child: Text(
                    'No students found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      color: Colors.black,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProfileScreen(nameEntry: student));
                        },
                        leading: student.imageUrl.isNotEmpty
                            ? CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: Image.file(
                                    File(student.imageUrl),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : null,
                        title: Text(
                          student.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          overflow: TextOverflow.ellipsis,
                          student.place,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 224, 221, 221),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => EditStudent(
                                    nameEntry: student, index: index));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.lightBlue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Delete !!",
                                  titleStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  content: const Text(
                                    'Are you sure you want to delete this student?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        studentController.deleteStudent(index);
                                        Get.back();
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}
