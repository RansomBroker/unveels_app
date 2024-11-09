

/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_us_screen_event.dart';
import 'contact_us_screen_repository.dart';
import 'contact_us_screen_state.dart';


class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsRepository? repository;

  ContactUsBloc({this.repository}) : super(ContactUsInitialState()) {
    on<ContactUsEvent>(mapEventToState);
  }

  void mapEventToState(
      ContactUsEvent event, Emitter<ContactUsState> emit) async {
    if (event is AddCommentEvent) {
      emit(ContactUsLoadingState());
      try {
        var model = await repository?.addComment(event.name, event.email, event.telephone, event.comment );
        if (model != null) {
          emit(AddCommentSuccessState(model));
          if(model.success == true) {
            emit(AddCommentSuccessState(model));
          } else {
            emit(ContactUsErrorState(model.message! ?? ""));
          }
        } else {
          emit(const ContactUsErrorState(''));
        }

      } catch (error, _) {
        print(error.toString());
        emit(ContactUsErrorState(error.toString()));
      }
    }
  }

}