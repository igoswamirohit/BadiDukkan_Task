import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/logic/models/user.dart';
import 'package:task/screens/details/details_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BehaviorSubject<List<Person>> persons = BehaviorSubject.seeded([
    Person(name: 'Sasuke Uchiha',
        address: 'Village of Shadows',
        age: 25,
        gender: Genders.male,
        mobileNumber: '9874569857',
        skills: ['Chhidori', 'Suseno', 'Sharengan', 'Rinnegan'],
    ),
    Person(name: 'Itachi Uchiha',
      address: 'Akatsuki\'s den',
      age: 29,
      gender: Genders.male,
      mobileNumber: '9875569857',
      skills: ['Suseno', 'Sharengan', 'Mangekyo', 'Sharingan', 'Amaterasu'],
    ),
    Person(name: 'Naruto Uzuzmaki',
      address: 'Hidden Leaf Village (Konoha)',
      age: 25,
      gender: Genders.male,
      mobileNumber: '9875567856',
      skills: ['Sage of Six Paths', 'Rasengan', 'Shadow Clone', 'Harem Justsu', 'Rasenshuriken'],
    ),
    Person(name: 'Minoto Namikaze',
      address: 'Hidden Leaf Village (Konoha)',
      age: 35,
      gender: Genders.male,
      mobileNumber: '7475567856',
      skills: ['Rasengan', 'Shadow Clone', 'Teleportation', 'Massive Rasengan', 'Sealing Jutsu'],
    ),
    Person(name: 'Madara Uchiha',
      address: 'Hidden Leaf Village (Konoha)',
      age: 45,
      gender: Genders.male,
      mobileNumber: '7475567856',
      skills: ['Sharengan', 'Mangekyo', 'Teleportation', 'Rinnegan', 'Infinite Suseno'],
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
            itemBuilder: (context, index) {
          var person = persons.value[index];
          return ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context)
            => DetailPage(person: person, onUpdate: (updatedPerson) {
              person = updatedPerson;
            },),),),
            title: Text(person.name),
            subtitle: Text(person.address),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        }, separatorBuilder:
            (context, index) => const SizedBox(height: 10,),
            itemCount: persons.value.length)
      ),
    );
  }
}
