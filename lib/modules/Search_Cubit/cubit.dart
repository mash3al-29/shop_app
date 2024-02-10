import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Search_Model.dart';
import 'package:shop_app/modules/Search_Cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.PostData(
      url: SEARCH,
      token: CacheHelper.GetData(key: 'token'),
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSucsessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}