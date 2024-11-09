/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class WalkThroughEvent extends Equatable{
  const WalkThroughEvent();

  @override
  List<Object> get props => [];
}

class WalkThroughFetchEvent extends WalkThroughEvent{
  const WalkThroughFetchEvent();
}

