import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:virtualcard/models/contact_model.dart';
import 'package:virtualcard/pages/form_page.dart';
import 'package:virtualcard/pages/home_page.dart';
import 'package:virtualcard/pages/scan_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: _router,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _router = GoRouter(debugLogDiagnostics: true, routes: [
    GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              name: ScanPage.routeName,
              path: ScanPage.routeName,
              builder: (context, state) => const ScanPage(),
              routes: [
                GoRoute(
                  name: FormPage.routeName,
                  path: FormPage.routeName,
                  builder: (context, state) => FormPage(contactModel: state.extra! as ContactModel,),
                )
              ])
        ])
  ]);
}
