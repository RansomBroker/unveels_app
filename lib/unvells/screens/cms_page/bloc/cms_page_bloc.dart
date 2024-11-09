/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../order_details/bloc/order_detail_screen_bloc.dart';
import 'cms_page_event.dart';
import 'cms_page_repository.dart';
import 'cms_page_state.dart';



class CmsPageBloc extends Bloc<CmsPageEvent, CmsPageState> {
  CmsPageRepository? repository;

  CmsPageBloc({this.repository}) : super(CmsPageInitialState()) {
    on<CmsPageEvent>(mapEventToState);
  }

  void mapEventToState(
      CmsPageEvent event, Emitter<CmsPageState> emit) async {
    if(event is CmsPageDetailsEvent){
      try {
        var model = await repository?.getCmsData(event.id);
        if (model != null) {
          emit( CmsPageSuccessState(model));
        } else {
          emit(CmsPageErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CmsPageErrorState(error.toString()));
      }
    }
  }
}