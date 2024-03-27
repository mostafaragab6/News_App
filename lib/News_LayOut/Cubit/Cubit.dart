import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Dio_Helper.dart';
import '../../Modules/Business_Screen.dart';
import '../../Modules/Science_Screen.dart';
import '../../Modules/Sports_Screen.dart';
import 'States.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super (NewsInitialState());

  static NewsCubit Get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List<BottomNavigationBarItem> Items =[
    BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_soccer),label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: "Science"),

  ];
  List<Widget> Screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()

  ];

  void ChangeNavBar(int index){
    currentIndex = index;
    if(index == 1){
      GetSports();
    }else if (index == 2){
      GetScience();
    }
    emit(ChangeNavBarState());
  }


  List<dynamic> Business=[];
  List<dynamic> Sports=[];
  List<dynamic> Science=[];
  List<dynamic> Search=[];

  void GetBusiness(){
    emit(NewsBusinessLoadingState());
    if(Business.length == 0){
      DioHelper.GetData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'business',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        Business = value.data['articles'];
        print(Business[1]);
        print('not exist');

        emit(NewsBusinessSuccessState());
      }).catchError((error){
        print('here  ');
        print(error.toString());
        emit(NewsBusinessErrorState());
      });

    }else
      emit(NewsBusinessSuccessState());


  }

  void GetSports(){
    emit(NewsSportsLoadingState());
    if(Sports.length == 0){
      DioHelper.GetData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'sports',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        Sports = value.data['articles'];
        emit(NewsSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSportsErrorState());
      });
    }
    else
      emit(NewsSportsSuccessState());

  }

  void GetScience(){
    emit(NewsScienceLoadingState());
    if(Science.length == 0){
      DioHelper.GetData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

          }).then((value) {
        Science = value.data['articles'];
        emit(NewsScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsScienceErrorState());
      });
    }
    else
      emit(NewsScienceSuccessState());



  }

  bool isDark = false;
  void ChangeMood(){
    isDark= !isDark;
    emit(ChangeMoodState());

  }

  void GetSearch(String value){
    emit(NewsSearchLoadingState());

    Search=[];

    DioHelper.GetData(
        url: 'v2/everything',
        query: {
          'q':'${value}',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
        })
        .then((value) {
      Search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsSearchErrorState());
    });





  }

  Future<bool> WebBage(String url)async{
    return await launchUrl(url as Uri).then((value) {
      emit(WebBageState());
      return true ;
    });



  }
}