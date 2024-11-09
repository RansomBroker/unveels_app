/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import '../../../models/cms_page/cms_page_model.dart';

abstract class CmsPageState extends Equatable {
  const CmsPageState();

  @override
  List<Object?> get props => [];

}


class CmsPageInitialState extends CmsPageState{}

class CmsPageLoadingState extends CmsPageState{}

class CmsPageSuccessState extends CmsPageState{
  final CmsPageModel data;

  CmsPageSuccessState(this.data);
}

class CmsPageErrorState extends CmsPageState{
  final String message;
  const CmsPageErrorState(this.message);
}