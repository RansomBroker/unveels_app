
/*
 *


 *
 * /
 */

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/deliverboy_admin_chat/bloc/deliveryboy_help_chat_event.dart';

import 'deliveryboy_help_chat_repository.dart';
import 'deliveryboy_help_chat_screen_state.dart';

class DeliveryboyHelpChatBloc extends Bloc<DeliveryboyHelpChatEvent, DeliveryboyHelpChatState> {
  DeliveryboyHelpChatRepositoryImp? repository;

  DeliveryboyHelpChatBloc({this.repository}) : super(SellerListInitial()) {
    on<DeliveryboyHelpChatEvent>(mapEventToState);
  }

  void mapEventToState(DeliveryboyHelpChatEvent event, Emitter<DeliveryboyHelpChatState> emit) async {
    if(event is UpdateTokenEvent){
      // emit(SellerListInitial());
      try {
        var model = await repository?.getUpdateToken(event.userId, event.name, event.avatar, event.accountType, event.os, event.sellerId);
        if (model != null) {
          emit(const UpdateTokenSuccessState());
        } else {
          emit(UpdateTokenErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(UpdateTokenErrorState(error.toString()));
      }
    }
  }
}