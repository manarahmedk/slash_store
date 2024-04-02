import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_task/view/screens/home_screen.dart';
import 'package:slash_task/view_model/bloc/observer.dart';
import 'package:slash_task/view_model/bloc/product_cubit/product_cubit.dart';
import 'package:slash_task/view_model/data/local/shared_prefernce.dart';
import 'package:slash_task/view_model/data/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await LocalData.init();
  LocalData.clearData();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:  [
        BlocProvider(create: (context)=>ProductCubit(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        home: HomeScreen(),
      ),
    );
  }
}
