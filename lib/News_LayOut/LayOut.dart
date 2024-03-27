import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Consts/Components.dart';
import '../Modules/Search_Screen.dart';
import 'Cubit/Cubit.dart';
import 'Cubit/States.dart';

class NewsLayOut extends StatelessWidget {
  const NewsLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        var Cubit = NewsCubit.Get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500
              ),),
            actions: [
              IconButton(onPressed: (){
                navigatTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: IconButton(onPressed: (){
                  NewsCubit.Get(context).ChangeMood();
                }, icon: Icon(Icons.brightness_2_outlined)),
              ),

            ],

          ),
          body: Cubit.Screens[Cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: Cubit.Items,
            currentIndex: Cubit.currentIndex,
            onTap: (index){
              Cubit.ChangeNavBar(index);
            },
          ),
        );
      },
      listener: (BuildContext context, NewsStates state) {  },
    );
  }
}
