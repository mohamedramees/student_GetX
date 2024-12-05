import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String imageUrl;

  Student(
      {
      required this.place,
      required this.name,
      required this.age,
      required this.phoneNumber,
      required this.imageUrl});
}
