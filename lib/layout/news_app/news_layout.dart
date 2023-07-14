import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/search/search.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/cubit_main.dart';
import 'cubit/states.dart';

class NewsApp extends StatelessWidget {
  const NewsApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context, state){},
      builder: (context , state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
          title: Text('News'),
          actions:
          [
            IconButton
              (onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
              icon: Icon(Icons.search,),
            ),
            IconButton
              (onPressed: ()
            {
              MainCubit.get(context).changeAppMode();
            },
              icon: Icon(Icons.brightness_4,),
            ),
          ],
        ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            items: cubit.bottomItems,
          ),
      );
      },
    );
  }
}
