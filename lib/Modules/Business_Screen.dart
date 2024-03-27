import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Consts/Components.dart';
import '../News_LayOut/Cubit/Cubit.dart';
import '../News_LayOut/Cubit/States.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        var Cubit = NewsCubit.Get(context);
        return ConditionalBuilder(
            condition: Cubit.Business.length>0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) =>
                Cubit.Business[index]['urlToImage']!=null?
                BuildArticle(Cubit.Business[index],context):SizedBox(),
                separatorBuilder: (context , index) =>
                Cubit.Business[index]['urlToImage']!=null?
                    Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 40.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                ):SizedBox(),
                itemCount: Cubit.Business.length),
            fallback: (context )=>Center(child: CircularProgressIndicator()));
      },
      listener: (BuildContext context, NewsStates state) {  },

    );
  }
}
