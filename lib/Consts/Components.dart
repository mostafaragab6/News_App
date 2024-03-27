import 'package:flutter/material.dart';
import 'package:news_app/News_LayOut/Cubit/Cubit.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton (
    {
      double width = double.infinity,
      bool upper = false,
      Color color = Colors.blue,
      required String text,
      required void Function() function
    }
    )=> Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color

  ),
  height: 40.0,
  width: width,
  child:   MaterialButton(
    onPressed: function,
    child: Text( upper? text.toUpperCase() : text,
      style: TextStyle(
          color: Colors.white
      ),),

  ),
);

Widget defaultForm ({
  String? Function(String?)? onChange,
  required TextEditingController controller,
  required IconData prefix,
  IconData? suffix,
  required TextInputType type ,
  String? Function(String?)? validate,
  required String label,
  String? Function(String?)? onSupmit ,
  void Function()? onClick ,
  bool isPassword = false ,
  void Function()? onTap ,
}
    )=> TextFormField(


  onChanged:onChange ,
  onTap: onTap,
  obscureText: isPassword ? true : false,
  keyboardType: type,
  controller:controller ,
  validator: validate ,
  decoration: InputDecoration(

      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      prefixIcon: Icon (prefix),
      suffixIcon:suffix !=null ? IconButton(onPressed: onClick,icon:Icon(suffix)) : null,
      label: Text(label)

  ),
  onFieldSubmitted: onSupmit,

);



Widget BuildArticle (article,context)=>

    Padding(

      padding: const EdgeInsets.all(15.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(

            children: [

              Container(

                width: 120.0,

                height: 120.0,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20.0),

                  image:DecorationImage(image: NetworkImage('${article['urlToImage']}',

                  ),fit: BoxFit.cover),

                ),

              ),

              SizedBox(width: 10.0,),

              Expanded(

                child: Container(

                  height: 120.0,

                  child: Column(

                    children: [

                      Expanded(

                        child: Text('${article['title']}',

                          style:
                         NewsCubit.Get(context).isDark? TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70
                          ):TextStyle(
                             fontSize: 18.0,
                             fontWeight: FontWeight.w600,
                             color: Colors.black
                         ),


                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,),

                      ),

                      Text('${article['publishedAt']}',

                        style: TextStyle(

                            fontSize: 20.0,

                            color: Colors.grey

                        ),),

                    ],

                  ),

                ),

              ),

            ],

          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            InkWell(
              onTap:(){
                launchUrl(Uri.parse(article['url']));
              },
              child: Row(
                children: [
                  Text('More',
                  style:  NewsCubit.Get(context).isDark? TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70
                  ):TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                  ),),
                  SizedBox(width: 5.0,),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),

            ],
            )
        ],
      ),

    );

void navigatTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder:(context)=> widget)
);

void navigateAndFinish (context , widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false);







