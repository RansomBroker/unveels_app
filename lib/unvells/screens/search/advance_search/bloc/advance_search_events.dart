/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class AdvanceSearchEvent extends Equatable{
  const AdvanceSearchEvent();

  @override
  List<Object> get props => [];
}

class InitialAdvanceSearchEvent extends AdvanceSearchEvent{}
