import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/logic/blocs/authentication/authentication_bloc.dart';
import 'package:task/repositories/authentication_repository/authentication_repository.dart';
import 'package:task/screens/authentication/login_page.dart';
import 'package:task/utils/router.dart';


class App extends StatelessWidget {
  const App();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) =>
                AuthenticationRepository(FirebaseAuth.instance),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (ctx) => AuthenticationBloc
                  (ctx.read<AuthenticationRepository>())),
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if(state is AuthenticationSuccess)
            {
              _navigator!.pushNamedAndRemoveUntil(
                  '/', (route) => false);
            }else if(state is AuthenticationFailure){
              _navigator!.pushNamedAndRemoveUntil(LoginPage.routeName,
                      (route) => false);
            }
          },
          child: child,
        );
      },
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
