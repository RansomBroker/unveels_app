/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class AccountInfoEvent extends Equatable {
  const AccountInfoEvent();

  @override
  List<Object> get props => [];
}

class DownloadInformationEvent extends AccountInfoEvent {
  const DownloadInformationEvent();
}

class SaveAccountInfoEvent extends AccountInfoEvent {
  final String
            prefix,
            firstName,
            middleName,
            lastName,
            suffix,
            dob,
            taxvat,
            gender,
            email,
            mobile,
            newPassword,
            currentPassword,
            confirmPassword;
  final int doChangeEmail,
            doChangePassword;


  const SaveAccountInfoEvent(
      this.prefix,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.dob,
      this.taxvat,
      this.gender,
      this.email,
      this.mobile,
      this.newPassword,
      this.currentPassword,
      this.confirmPassword,
      this.doChangeEmail,
      this.doChangePassword);
}

class AccountDetailEvent extends AccountInfoEvent {
  const AccountDetailEvent();
}

class DeactivateAccount extends AccountInfoEvent {
  final String type;

  const DeactivateAccount(this.type);
}

class ReSendVerificationEvent extends AccountInfoEvent {
  const ReSendVerificationEvent();
}

class LoginEvent extends AccountInfoEvent {
  const LoginEvent(this.name, this.password, this.fcmToken, this.wkToken);

  final String name;
  final String password;
  final String wkToken;
  final String fcmToken;

  @override
  List<Object> get props => [name, password, fcmToken, wkToken];
}
class DeleteAccountEvent extends AccountInfoEvent {

  final String email;
  final String password;

  const DeleteAccountEvent(this.email, this.password);
}
