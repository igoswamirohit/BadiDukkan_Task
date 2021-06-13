import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/logic/blocs/authentication/authentication_bloc.dart';
import 'package:task/screens/home/home_page.dart';
import 'package:task/utils/constants.dart';

import '../../theme.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('hh ${FirebaseAuth.instance.currentUser}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // ignore: sized_box_for_whitespace
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              print(snapshot.data?.uid);
              if(snapshot.hasData && snapshot.data != null){
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
                return Container();
              }else{
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 240,
                                          constraints:
                                          const BoxConstraints(maxWidth: 500),
                                          margin: const EdgeInsets.only(top: 100),
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFE1E0F5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                            constraints:
                                            const BoxConstraints(maxHeight: 340),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child:
                                            Image.asset('assets/img/login.png')),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: const Text('BadiDukkan Task',
                                        style: TextStyle(
                                            color: MyColors.primaryColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800)))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    constraints: const BoxConstraints(maxWidth: 500),
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: const TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'We will send you an ',
                                            style: TextStyle(
                                                color: MyColors.primaryColor)),
                                        TextSpan(
                                            text: 'One Time Password ',
                                            style: TextStyle(
                                                color: MyColors.primaryColor,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: 'on this mobile number',
                                            style: TextStyle(
                                                color: MyColors.primaryColor)),
                                      ]),
                                    )),
                                Container(
                                  height: 40,
                                  constraints: const BoxConstraints(maxWidth: 500),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: CupertinoTextField(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                    controller: phoneController,
                                    clearButtonMode: OverlayVisibilityMode.editing,
                                    keyboardType: TextInputType.phone,
                                    maxLines: 1,
                                    maxLength: 13,
                                    placeholder: '+91...',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  constraints: const BoxConstraints(maxWidth: 500),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (phoneController.text.isEmpty) {
                                        buildSnackBar(
                                            context: context,
                                            message:
                                            '''Please Enter 10 
                                              Digits Mobile Number.''');
                                      }
                                      var phone = phoneController.text.contains('+91')
                                          ? phoneController.text
                                          : '+91${phoneController.text}';
                                      context.read<AuthenticationBloc>().add(
                                          AuthenticateUserRequested(context, phone));
                                      // Navigator.of(context)
                                      // .pushNamed(OtpPage.routeName);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: MyColors.primaryColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            'Next',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: MyColors.primaryColorLight,
                                            ),
                                            child: BlocBuilder<AuthenticationBloc,
                                                AuthenticationState>(
                                              builder: (context, state) {
                                                if (state
                                                is AuthenticationInProgress) {
                                                  return
                                                    // ignore: sized_box_for_whitespace
                                                    Container(height:20,
                                                        width:20,
                                                        child: const
                                                        CircularProgressIndicator(
                                                          color: Colors.amber,
                                                        ));
                                                } else {
                                                  return const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                    size: 16,
                                                  );
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            }
          ),
        ),
      ),
    );
  }
}
