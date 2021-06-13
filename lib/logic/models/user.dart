import 'package:equatable/equatable.dart';

class Person extends Equatable {
  
  Person({
    required this.name,
    required this.address,
    required this.age,
    required this.gender,
    required this.mobileNumber,required this.skills,
  });
  
  final String name;
  final int age;
  final String mobileNumber;
  final String address;
  final Genders gender;
  List<String> skills;

  @override
  List<Object?> get props => [name, age, skills, mobileNumber, gender, address];
}

enum Genders{male, female, others}
