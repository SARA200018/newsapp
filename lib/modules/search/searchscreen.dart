import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
class SearchScreen extends StatelessWidget {
  var SeachControlar = TextEditingController();
   //var TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  Controlar: SeachControlar,
                  keyboardType: TextInputType.text,
                  prefix: Icons.search,
                  InputDecorationn: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:BorderSide(color: Colors.white)
                    )
                  ),
                  Label: 'Search',
                 /// validator: ,
                  onchanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  }
                ),
                Expanded(child: articleBuilder (list , isSearch: true)),

              ],
            ),
          ),
        );
    },


    );
  }
}
