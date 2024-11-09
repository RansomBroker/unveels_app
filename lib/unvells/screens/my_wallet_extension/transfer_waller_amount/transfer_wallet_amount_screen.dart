import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/bloc/transfer_wallet_amount_state.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/view/add_payee_form.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/view/payee_list_view.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/view/transfer_money_view.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/view/transfer_verification_Otp.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../constants/app_constants.dart';
import '../../../models/wallet_extension_models/wallet_dashboard_model.dart';
import '../manage_wallet/view/wallet_dashboard_view.dart';
import 'bloc/transfer_wallet_amount_bloc.dart';
import 'bloc/transfer_wallet_amount_event.dart';

class TransferWalletAmountScreen extends StatefulWidget {
  const TransferWalletAmountScreen({super.key});

  @override
  State<TransferWalletAmountScreen> createState() =>
      _TransferWalletAmountScreenState();
}

class _TransferWalletAmountScreenState
    extends State<TransferWalletAmountScreen> {
  TrasnferWalletAmountBloc? bloc;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController confirmMailCtrl = TextEditingController();
  bool isLoading = true;
  WalletDashboardModel? transferModel;
  String errorMessage = "";
  List<DropdownMenuItem<String>> transferPayeeList = [];

  @override
  void initState() {
    super.initState();
    bloc = context.read<TrasnferWalletAmountBloc>()..add(GetTransferDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF5F5F5),
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.transferWallet),
          bgColor: Colors.white,
          context),
      body: BlocBuilder<TrasnferWalletAmountBloc, TrasnferWalletAmountStates>(
        builder: (context, state) {
          if (state is TrasnferWalletAmountInitialState) {}
          if (state is TrasnferWalletAmountLoadingState) {
            isLoading = true;
          } else if (state is TrasnferWalletAmountErrorState) {
            isLoading = false;
          } else if (state is TransferWallerDetailsSuccess) {
            isLoading = false;
            transferModel = state.model;
            transferPayeeList.clear();
            transferPayeeList =
                addPayeeForTransfer((transferModel?.payeeList ?? []));
          } else if (state is AddPayeeSuccessState) {
            isLoading = false;
            if (state.model?.success ?? false) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state?.model?.message ?? "", context);
              });
              bloc?.add(GetTransferDetails());
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state?.model?.message ?? "", context);
              });
            }
          } else if (state is UpdatePayeeSuccessState) {
            isLoading = false;
            if (state.model?.success ?? false) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state?.model?.message ?? "", context);
              });
              bloc?.add(GetTransferDetails());
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state?.model?.message ?? "", context);
              });
            }
          } else if (state is SendCodeSuccessState) {
            isLoading = false;
            if (state.model?.success ?? false) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state?.model?.message ?? "", context);

                if (state.model?.transferValidation ?? false) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => showOtpScreen(_, (value) {
                            bloc?.add(SendMoneyEvent(
                                id: state.id,
                                amount: state.amount,
                                note: state.note,
                                otp: value));
                            Navigator.of(_).pop();
                          }));
                } else {
                  bloc?.add(GetTransferDetails());
                }
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state?.model?.message ?? "", context);
              });
            }
          }
          bloc?.emit(TrasnferWalletAmountInitialState());
          return Stack(
            children: [
              isLoading ? const Loader() : const SizedBox(),
              buildUI()
            ],
          );
        },
      ),
    );
  }

  Widget buildUI() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          walletDashboardView(
            context,
            transferModel,
            false,
          ),
          Container(
            width: AppSizes.deviceWidth,
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AddPayee(onTap: (name, email) {
                          bloc?.add(AddPayeeEvent(
                            name,
                            email,
                          ));
                        }),
                      );
                    },
                    title: Utils.getStringValue(
                        context, AppStringConstant.addPayee),
                    // child: Text(Utils.getStringValue(
                    //     context, AppStringConstant.addPayee)),
                  ),
                ),
                if ((transferModel?.payeeList ?? []).isNotEmpty) ...[
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return TransferMoneyView(
                              callBack: (int id, int amount, String note) {
                                bloc?.add(SendCodeEvent(
                                    id: id, amount: amount, note: note));
                                Navigator.of(_).pop();
                              },
                              transferPayeeList: transferPayeeList,
                              payeeList: (transferModel?.payeeList ?? []),
                            );
                          },
                        );
                      },
                      kFillColor: AppColors.gold,
                      title: Utils.getStringValue(
                          context, AppStringConstant.transferMoney),
                      // child: Text(Utils.getStringValue(
                      //     context, AppStringConstant.transferMoney)),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: AppSizes.deviceWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Theme.of(context).cardColor,
            child: Text(
              Utils.getStringValue(context, AppStringConstant.payeeList),
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          payeeListView(context, (transferModel?.payeeList ?? []), (item) {
            showDialog(
              context: context,
              builder: (ctx) => AddPayee(
                  email: item.email ?? "",
                  name: item.name ?? "",
                  onTap: (name, email) {
                    bloc?.add(UpdatePayee(id: item.id, name: name));
                  }),
            );
          }, (item) {
            bloc?.add(DeletePayee(id: item.id));
          }),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> addPayeeForTransfer(List<PayeeList> list) {
    List<DropdownMenuItem<String>> payees = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        payees.add(DropdownMenuItem(
            value: (item.customerId ?? 0).toString(),
            child: Wrap(
              children: <Widget>[
                Text(
                  "${item.name} (${item.email})",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            )));
      }
    }
    return payees;
  }
}
