import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'layouts/news_layout.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  //بيتأكد  انو كل الميثودز خلصت وبعدين بيعمل رن لل آبليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  cacheHelper.init();
  bool? isDark = cacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
        create: (BuildContext context) =>
    NewsCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience())
      ],
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // to make all transition in the app the same color
              // such as loading
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('#ffffff'),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  //   backwardsCompatibility: false,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('#434343'),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#434343'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('#434343'),
                  elevation: 20.0),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: HexColor('#434343'),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            //NewsCubit.get(context).isDark? ThemeMode.light : ThemeMode.dark,
            home: Directionality(
                textDirection: TextDirection.ltr, child: newsLayout()),
          );
        },
      ),
    );
  }
}
