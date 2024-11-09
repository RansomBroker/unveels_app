import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/screens/login_signup/bloc/signin_signup_screen_repository.dart';
import '../../../models/base_model.dart';
import '../../../models/cart/customer_cart_model.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../../models/login_signup/sign_up_screen_model.dart';
import '../../../models/login_signup/signup_response_model.dart';
import '../../../models/login_signup/social_login_model.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'signin_signup_screen_event.dart';
part 'signin_signup_screen_state.dart';

class AuthBloc extends Bloc<SigninSignupScreenEvent, SigninSignupScreenState> {
  AuthRepository? repository;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  AuthBloc({
    this.repository,
    // required this.firebaseAuth,
    // required this.googleSignIn,
  }) : super(SignupScreenInitial()) {
    on<SigninSignupScreenEvent>(mapEventToState);
  }

  CustomerCartData? customerCartData;
  bool customerCartLoading = false;

  void mapEventToState(
      SigninSignupScreenEvent event,
      Emitter<SigninSignupScreenState> emit,
      ) async {
    if (event is SignUpEvent) {
      try {
        var model = await repository?.signUp(
            event.prefix,
            event.firstName,
            event.middleName,
            event.lastName,
            event.suffix,
            event.dob,
            event.taxvat,
            event.gender,
            event.email,
            event.password,
            event.mobile);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SignupScreenFormDataEvent) {
      try {
        var model = await repository?.signUpFormData();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormDataState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is LoginEvent) {
      try {
        var model = await repository?.login(event.email, event.password);
        if (model != null) {
          if (model.success ?? false) {
            emit(LoginState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is ForgotPasswordEvent) {
      try {
        var model = await repository?.forgotPassword(event.email);
        if (model != null) {
          if (model.success ?? false) {
            emit(ForgotPasswordState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is GetCustomerCartEvent) {
      try {
        customerCartLoading = true;
        var model = await repository?.customerCart();
        if (model != null) {
          emit(GetCustomerCartState(model));
          if (model.id != null) {
            appStoragePref.setCartId(model.id);
          }
          customerCartData = model;
          debugPrint("GetCustomerCartState${appStoragePref.getCartId()}");
          customerCartLoading = false;
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SocialLoginEvent) {
      print("TEST_LOG==> SocialLoginEvent ==> ${event.request.email}");
      try {
        var model = await repository?.socialLogin(event.request);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is GoogleSignInEvent) {
      emit(SocialLoginLoadingState());
      try {

        var googleSignIn = GoogleSignIn(scopes: ['email']);
        log("message");

        /// Need to disconnect or cannot login with another account.
        try {
          await googleSignIn.disconnect();
        } catch (_) {
          // ignore.
        }

        var res = await googleSignIn.signIn();
        final googleAuth = await res?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final user = (await firebaseAuth.signInWithCredential(credential)).user;
        // if (user == null) {
        //   emit(SocialLoginErrorState("Google sign-in failed."));
        // } else {
        //   var model = await repository?.socialLogin(SocialLoginModel(
        //     email: user.email,
        //     firstName: user.displayName?.split(' ')[0],
        //     lastName: user.displayName!.split(' ').length > 1 ? user.displayName?.split(' ')[1] : '',
        //     id: user.uid,
        //   ));
        //   if (model != null && model.success == true) {
        //     emit(SignupScreenFormSuccess(model));
        //   } else {
        //     emit(SigninSignupScreenError(model?.message ?? "Social login error."));
        //   }
        // }
      } catch (e) {
        emit(SocialLoginErrorState("Google sign-in error: ${e.toString()}"));
      }
    } else if (event is AppleSignInEvent) {
      emit(SocialLoginLoadingState());
      try {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        final user = (await firebaseAuth.signInWithCredential(oauthCredential)).user;
        if (user == null) {
          emit(SocialLoginErrorState("Apple sign-in failed."));
        } else {
          var model = await repository?.socialLogin(SocialLoginModel(
            email: user.email,
            firstName: appleCredential.givenName,
            lastName: appleCredential.familyName,
            id: user.uid,
          ));
          if (model != null && model.success == true) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model?.message ?? "Social login error."));
          }
        }
      } catch (e) {
        emit(SocialLoginErrorState("Apple sign-in error: ${e.toString()}"));
      }
    }
  }
}
enum SocialLogins {
  google,
  apple,
  facebook
}