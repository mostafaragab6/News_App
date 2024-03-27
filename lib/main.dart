import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/News_LayOut/Cubit/Cubit.dart';
import 'package:news_app/News_LayOut/Cubit/States.dart';
import 'package:news_app/News_LayOut/LayOut.dart';

import 'Cache_Helper.dart';
import 'Dio_Helper.dart';
void main()async {


  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();


  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>NewsCubit()..GetBusiness()..GetScience()..GetSports()
          ),
        ],

        child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (

              BuildContext context, NewsStates state) => MaterialApp(

              theme: ThemeData(
                //fontFamily: 'newFont',
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),

                  primarySwatch: Colors.teal,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.teal[700]
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(color: Colors.black ,fontSize: 45.0),
                    //titleSpacing: 25.0
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.teal[700]
                  )
              ),
              darkTheme: ThemeData(

                  iconTheme: IconThemeData(
                      color: Colors.white
                  ),

                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.teal[700],
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.black,
                      elevation: 20.0
                  ),
                  scaffoldBackgroundColor: Colors.black,
                  primarySwatch: Colors.grey,
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      backgroundColor: Colors.black,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.black,
                          statusBarIconBrightness: Brightness.light
                      ),
                    titleTextStyle: TextStyle(
                      color: Colors.white
                    )
                  ),

                  cardTheme: CardTheme(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.grey[700]
                  ),


              ),

              themeMode: NewsCubit.Get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
              debugShowCheckedModeBanner: false,
              home:NewsLayOut()
          ),
          listener: (BuildContext context, NewsStates state) {  },

        ),

      );



  }

}