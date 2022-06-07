import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/search/searchscreen.dart';
import 'package:news_app/shared/components/components.dart';


class newsLayout extends StatefulWidget {
  const newsLayout({Key? key}) : super(key: key);

  @override
  _newsLayoutState createState() => _newsLayoutState();
}

class _newsLayoutState extends State<newsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  Navegato(context,SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: (){
                  NewsCubit.get(context).changeAppMode();
                  //NewsCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_sharp),
              )
            ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              iconSize: 35.0,
              selectedFontSize: 15,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}
