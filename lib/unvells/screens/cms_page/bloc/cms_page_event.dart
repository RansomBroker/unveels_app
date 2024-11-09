
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class CmsPageEvent extends Equatable {
  const CmsPageEvent();

  @override
  List<Object> get props => [];
}

class CmsPageDetailsEvent extends CmsPageEvent{
  String id;
  CmsPageDetailsEvent(this.id);
}