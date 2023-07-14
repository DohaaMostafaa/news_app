import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/component/component.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var searchController = TextEditingController();
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultFormField(
                  controller:searchController,
                  type: TextInputType.text,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value!);
                  },
                  validate: (String?value)
                  {
                    if(value!.isEmpty)
                    {
                      return'Search Must Not Be Empty';
                    }

                  },
                  borderColor: Colors.deepOrange,
                  label: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                  child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
