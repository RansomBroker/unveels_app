
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/deliveryboyHelpChat/deliveryboy_help_chat_model.dart';

abstract class DeliveryboyHelpChatState extends Equatable {
  const DeliveryboyHelpChatState();

  @override
  List<Object> get props => [];
}

class SellerListInitial extends DeliveryboyHelpChatState {}

class SellerListSuccess extends DeliveryboyHelpChatState {
  DeliveryboyHelpChatModel? data;
  SellerListSuccess(this.data);
}

class SellerListMpError extends DeliveryboyHelpChatState {
  final String message;
  const SellerListMpError(this.message);
}

class SellerListMpSearch extends DeliveryboyHelpChatState {
  final String query;
  const SellerListMpSearch(this.query);
}

class SellerListMpEmpty extends DeliveryboyHelpChatState {}

class UpdateTokenSuccessState extends DeliveryboyHelpChatState{
  const UpdateTokenSuccessState();
}

class UpdateTokenErrorState extends DeliveryboyHelpChatState{
  final String message;
  UpdateTokenErrorState(this.message);
}
