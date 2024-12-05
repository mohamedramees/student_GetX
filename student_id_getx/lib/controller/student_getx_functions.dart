import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_id_getx/model/student_model.dart';

class StudentController extends GetxController {
  final Box<Student> nameBox = Hive.box<Student>('Student');

  var students = <Student>[].obs;
  var selectedImage = RxnString();
  var filteredStudents = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    students.value = nameBox.values.toList();
    filteredStudents.assignAll(students);
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(
        students.where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void addStudent(String name, int age, String place, String phoneNumber, String imageUrl) {
    final student = Student(
      place: place,
      name: name,
      age: age,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
    );
    nameBox.add(student);
    students.add(student); 
  }

  void updateStudent(int index, String name, String place, int age, String imageUrl, String phoneNumber) {
    final updatedStudent = Student(
      place: place,
      name: name,
      age: age,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
    );
    nameBox.putAt(index, updatedStudent);
    students[index] = updatedStudent; 
  }

  void deleteStudent(int index) {
    nameBox.deleteAt(index);
    students.removeAt(index); 
  }

  List<Student> searchStudents(String query) {
    if (query.isEmpty) {
      return students;
    } else {
      return students
          .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      selectedImage.value = pickedImage.path;
    }
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }
}
