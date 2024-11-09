/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_methods_model.dart';


abstract class ShippingScreenState {
  const ShippingScreenState();

  @override
  List<Object> get props => [];
}

class ShippingScreenInitial extends ShippingScreenState {}
class ShippingScreenEmptyState extends ShippingScreenState {}

class ShippingAddressSuccess extends ShippingScreenState {
  final ShippingAddressModel model;

  const ShippingAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class ShippingMethodSuccess extends ShippingScreenState {
  final ShippingMethodsModel model;

  const ShippingMethodSuccess(this.model);

  @override
  List<Object> get props => [];
}

class ShippingError extends ShippingScreenState {
  ShippingError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class ChangeShippingAddressState extends ShippingScreenState {
  const ChangeShippingAddressState();
}
