import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states_main.dart';
import '../../../shared/network/local/cache_helper.dart';


class MainCubit extends Cubit<MainStates>
{
  MainCubit() :super(InitialState());
  static MainCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared!=null)
      isDark=fromShared;
    else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeBrightnessState());
      });
        }
  }

}