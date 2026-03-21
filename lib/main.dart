import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_list_screen/bloc/news_bloc.dart';
import 'package:news_list_screen/data/repository/news_repository.dart';
import 'package:news_list_screen/data/services/api_service.dart';
import 'package:news_list_screen/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc(
        NewsRepository(ApiService()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
