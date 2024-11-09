

/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object> get props => [];
}

class AddCommentEvent extends ContactUsEvent{
  final String name;
  final String email;
  final String telephone;
  final String comment;

  AddCommentEvent(this.name,this.email,this.telephone ,this.comment);
}
