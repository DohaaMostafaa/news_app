import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit_main.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import '../layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states_main.dart';
import 'layout/news_app/news_layout.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark =CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>NewsCubit()..getBusiness(),),
        BlocProvider(
          create: (BuildContext context)=>MainCubit()..changeAppMode(fromShared: isDark,),),
      ],
      child: BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return  MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyText1:TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              textTheme: TextTheme(
                bodyText1:TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              appBarTheme: AppBarTheme(
                  backgroundColor:HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:HexColor('333739') ,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('333739'),
              ),
            ),
            themeMode: MainCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home:NewsApp() ,
          );
        },
      ),
    );

  }
}