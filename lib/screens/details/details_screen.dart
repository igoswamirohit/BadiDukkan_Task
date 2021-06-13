import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/logic/models/user.dart';
import 'package:task/utils/constants.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.person, required this.onUpdate})
      : super(key: key);

  static const routeName = '/DetailPage';
  final Person person;
  final Function(Person updatedPerson) onUpdate;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addSkillController = TextEditingController();
  late BehaviorSubject<List<String>> skills;
  late BehaviorSubject<Genders> selectedGender;

  @override
  Widget build(BuildContext context) {
    print(Genders.values);
    selectedGender = BehaviorSubject.seeded(widget.person.gender);
    skills = BehaviorSubject.seeded(widget.person.skills);
    nameController.text = widget.person.name;
    ageController.text = widget.person.age.toString();
    numberController.text = widget.person.mobileNumber;
    addressController.text = widget.person.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail/Edit'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.onUpdate(Person(
              name: nameController.text,
              mobileNumber: numberController.text,
              age: int.parse(ageController.text),
              address: addressController.text,
              gender: selectedGender.value,
              skills: skills.value));
          buildSnackBar(context: context, message: 'Data Updated Successfully');
        },
        label: const Text('Submit'),
        icon: const Icon(Icons.arrow_forward_ios),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(controller: nameController),
                buildTextField(controller: ageController),
                buildTextField(controller: addressController),
                buildTextField(
                    controller: numberController,
                    keyboardType: TextInputType.phone),
                const SizedBox(
                  height: 10,
                ),
                buildGenderDropDown(),
                const SizedBox(
                  height: 15,
                ),
                const Text('Skills'),
                StreamBuilder<List<String>>(
                    stream: skills,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Wrap(
                          children: List.generate(
                              snapshot.data!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ChoiceChip(
                                      label: Text(snapshot.data![index]),
                                      selected: true,
                                      selectedColor: Colors.lightBlue,
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  )),
                        );
                      } else {
                        return Container();
                      }
                    }),
                buildAddSkillBtn(context),
              ],
            ),
          )),
    );
  }

  TextButton buildAddSkillBtn(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Skills'),
                content: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildTextField(controller: addSkillController),
                      ElevatedButton(
                          onPressed: () {
                            var tempSkills = skills.value
                            ..add(addSkillController.text);
                            skills.add(tempSkills);
                            addSkillController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'))
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Skills'));
  }

  Widget buildGenderDropDown() {
    return StreamBuilder<Genders>(
        stream: selectedGender,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<Genders>(
                      value: snapshot.data,
                      onChanged: (value) {
                        selectedGender.add(value!);
                      },
                      items: Genders.values
                          .map<DropdownMenuItem<Genders>>(
                            (gender) => DropdownMenuItem(
                              value: gender.index == 0
                                  ? Genders.male
                                  : gender.index == 1
                                      ? Genders.female
                                      : Genders.others,
                              child: Text(
                                gender == Genders.male
                                    ? 'Male'
                                    : gender == Genders.female
                                        ? 'Female'
                                        : 'Others',
                              ),
                            ),
                          )
                          .toList())),
            );
          } else {
            return Container();
          }
        });
  }

  Widget buildTextField(
      {required TextEditingController controller,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        keyboardType: keyboardType,
      ),
    );
  }
}
