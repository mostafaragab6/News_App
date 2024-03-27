import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Consts/Components.dart';
import '../News_LayOut/Cubit/Cubit.dart';
import '../News_LayOut/Cubit/States.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
              NewsCubit.Get(context).Search=[];
            }, icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultForm(
                    controller: searchController,
                    prefix: Icons.search,
                    type: TextInputType.text,
                    label: 'Search',

                    onChange: (value){
                      NewsCubit.Get(context).GetSearch(value!);
                    }
                ),
              ),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics( ),
                    itemBuilder: (context , index)=> BuildArticle(NewsCubit.Get(context).Search[index], context),
                    separatorBuilder: (context , index)=>Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 40.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    itemCount: NewsCubit.Get(context).Search.length),
              )
            ],

          ),


        );
      },
      listener: (BuildContext context, NewsStates state) {  },

    );
  }
}
