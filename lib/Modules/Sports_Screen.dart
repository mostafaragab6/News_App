import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Consts/Components.dart';
import '../News_LayOut/Cubit/Cubit.dart';
import '../News_LayOut/Cubit/States.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        var Cubit = NewsCubit.Get(context);
        return ConditionalBuilder(
            condition: Cubit.Business.length>0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) =>BuildArticle(Cubit.Sports[index],context),
                separatorBuilder: (context , index) =>Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                itemCount: Cubit.Sports.length),
            fallback: (context )=>Center(child: CircularProgressIndicator()));
      },
      listener: (BuildContext context, NewsStates state) {  },

    );
  }
}
