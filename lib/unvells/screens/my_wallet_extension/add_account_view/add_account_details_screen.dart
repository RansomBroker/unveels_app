import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/add_account_view/view/add_account_form.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/view/payee_list_view.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';
import '../../../models/wallet_extension_models/account_details_model.dart';
import '../../../models/wallet_extension_models/add_account_form_model.dart';
import 'bloc/add_account_details_bloc.dart';
import 'bloc/add_account_details_events.dart';
import 'bloc/add_account_details_states.dart';

class AddAccountDetailsScreen extends StatefulWidget {
  const AddAccountDetailsScreen({super.key});

  @override
  State<AddAccountDetailsScreen> createState() =>
      _AddAccountDetailsScreenState();
}

class _AddAccountDetailsScreenState extends State<AddAccountDetailsScreen> {
  AddAccountDetailsBloc? bloc;
  AccountDetailsModel? accounts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddAccountDetailsBloc>(context)
      ..add(FetchSavedAccountDetailsEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF5F5F5),
      appBar: commonAppBar(
        bgColor: Colors.white,
          Utils.getStringValue(context, AppStringConstant.addAccountDetails),
          context,

          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AddAccountDetailsForm(
                        callBack: (value) {
                         bloc?.add(AddAccountDetailsFormEvents(AddAccountFormModel(
                           description: value.description,
                           bankName: value.bankName,
                           bankCode: value.bankCode,
                           acNumber: value.acNumber,
                           acHolderName: value.acHolderName,
                         )));
                          Navigator.of(_).pop();
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ]),
      body: BlocBuilder<AddAccountDetailsBloc, AddAccountDetailsStates>(
        builder: (context, state) {
          if (state is AddAccountDetailsInitialState) {
          } else if (state is AddAccountDetailsSuccessState) {
            isLoading = false;
            accounts = state.model;
            bloc?.emit(AddAccountDetailsInitialState());
          } else if (state is AddAccountDetailsFailureState) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AlertMessage.showError(state.message ?? "", context);
            });
            bloc?.emit(AddAccountDetailsInitialState());
          } else if (state is AddAccountDetailsLoadingState) {
            isLoading = true;
          } else if (state is AddAccountFormDetailsSuccessState) {
            isLoading = false;
            if(state.model?.success ?? true) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state.model?.message ?? "", context);
              });
            }else{
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state.model?.message ?? "", context);
              });
            }
            bloc?.add(FetchSavedAccountDetailsEvents());
          }else if(state is DeleteAccountSuccessState) {
            isLoading = false;
            if(state.model?.success ?? true) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state.model?.message ?? "", context);
              });
              bloc?.add(FetchSavedAccountDetailsEvents());
            }else{
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state.model?.message ?? "", context);
              });
            }
          }

          return Stack(
            children: [
              buildUI(),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget buildUI() {
    if(!isLoading && (accounts?.accountDetails ?? []).isEmpty){
      return Center(
        child: Text(Utils.getStringValue(context, AppStringConstant.noAccountFound),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 16
        ),),
      );
    }else {
      return Container(
          padding: EdgeInsets.all(16),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                );
              },
              itemCount: accounts?.accountDetails?.length ?? 0,
              itemBuilder: (context, index) {
                var item = accounts?.accountDetails?[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:  Colors.white,
                  ),
                  child: ListTile(
                    visualDensity: const VisualDensity(
                      vertical: 0,
                      horizontal: -4,
                    ),
                    title: Text(item?.acholderName ?? "",
                        style: Theme
                            .of(context)
                            .textTheme
                            ?.bodyLarge
                            ?.copyWith(fontSize: 15)),
                    subtitle: Column(
                      children: [
                        rowTextMapping(
                            context,
                            Utils.getStringValue(
                                context, AppStringConstant.bankName),
                            item?.bankName ?? ""),
                        rowTextMapping(
                            context,
                            Utils.getStringValue(
                                context, AppStringConstant.bankCode),
                            item?.bankCode ?? ""),
                        rowTextMapping(
                            context,
                            Utils.getStringValue(
                                context, AppStringConstant.accountNumber),
                            item?.acNumber ?? ""),
                        rowTextMapping(
                            context,
                            Utils.getStringValue(
                                context, AppStringConstant.additionalInformation),
                            item?.additionalInformation ?? ""),
                      ],
                    ),
                    trailing: (item?.requestForDelete ?? false) ? GestureDetector(
                      onTap: () {
                        bloc?.add(DeleteAccount(id: item?.id));
                      },
                      child: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ) : const SizedBox(),
                  ),
                );
              }));
    }
  }
}
