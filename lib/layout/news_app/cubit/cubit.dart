import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';

import '../../../modules/business_news/business_screen.dart';
import '../../../modules/science_news/science_screen.dart';
import '../../../modules/sports_news/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>
{
   NewsCubit() : super(InitialState());
   static NewsCubit get(context) => BlocProvider.of(context);

   int currentIndex =0;
   List<BottomNavigationBarItem> bottomItems =
       [
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.science),
             label: 'Science',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.sports),
             label: 'Sports',
          ),

       ];
   List<Widget> screens =
       [
          BusinessScreen(),
          ScienceScreen(),
          SportsScreen(),

       ];
   void changeBottom(int index)
   {
      currentIndex = index;
      if (index == 1)
        getScience();
     if (index == 1)
        getSports();
      emit(ChangeBottomState());

   }

   //Business
   List<dynamic> business =[];
   void getBusiness()
   {
     emit(BusinessLoadingState());
      DioHelper.getData(
          url:  'v2/top-headlines',
          query: {
             'country': 'eg',
             'category': 'business',
             'apiKey': 'c81f973e7faf471d83d516843db173c0'
          }
      ).then((value)
      {
        business = value.data['articles'];
         print(business[0]['title']);
        emit(BusinessState());
      }).catchError((error)
          {
             print(error.toString());
             emit(BusinessErrorState(error.toString()));

          });
   }

   //Sports
  List<dynamic> sports=[];
   void getSports()
   {
     emit(SportsLoadingState());
     DioHelper.getData(
         url:  'v2/top-headlines',
         query: {
           'country': 'eg',
           'category': 'sports',
           'apiKey': 'c81f973e7faf471d83d516843db173c0'
         }
     ).then((value)
     {
       sports = value.data['articles'];
       emit(SportsState());
     }).catchError((error)
     {
       print(error.toString());
       emit(SportsErrorState(error.toString()));

     });

   }

   //Science
  List<dynamic> science =[];
   void getScience()
   {
     emit(ScienceLoadingState());
     DioHelper.getData(
         url:  'v2/top-headlines',
         query: {
         'country': 'eg',
         'category': 'Science',
         'apiKey': 'c81f973e7faf471d83d516843db173c0'
         }).then((value)
           {
             science = value.data['articles'];
             emit(ScienceState());
           }).catchError((error)
           {
             print(error.toString());
             emit(ScienceErrorState(error));
           });

   }

   //Search
   List<dynamic> search =[];
   void getSearch(String value)
   {
     emit(SearchLoadingState());
     DioHelper.getData(
         url:  'v2/everything',
         query: {
           'q': '$value',
           'apiKey': 'c81f973e7faf471d83d516843db173c0'
         }).then((value)
     {
       search = value.data['articles'];
       emit(SearchState());
     }).catchError((error)
     {
       print(error.toString());
       emit(SearchErrorState(error));
     });

   }




}