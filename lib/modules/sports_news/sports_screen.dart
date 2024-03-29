import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../shared/component/component.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener:(context,state) {},
      builder: (context,state)
      {
        var list =NewsCubit.get(context).sports;
        return articleBuilder(list,context);

      },
    );
  }
}
