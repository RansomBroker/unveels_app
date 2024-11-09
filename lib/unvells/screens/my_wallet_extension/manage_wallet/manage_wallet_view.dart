import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/manage_wallet/view/show_transaction_detials.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/manage_wallet/view/transaction_history_detail_view.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/manage_wallet/view/transfer_amount_to_bank.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/manage_wallet/view/wallet_dashboard_view.dart';
import '../../../app_widgets/app_bar.dart';
import '../../../constants/app_constants.dart';
import '../../../models/wallet_extension_models/transaction_history_model.dart';
import '../../../models/wallet_extension_models/wallet_dashboard_model.dart';
import 'bloc/manage_wallet_bloc.dart';
import 'bloc/manage_wallet_events.dart';
import 'bloc/manage_wallet_states.dart';
class ManageWalletScreen extends StatefulWidget {
  const ManageWalletScreen({super.key});

  @override
  State<ManageWalletScreen> createState() => _ManageWalletScreenState();
}

class _ManageWalletScreenState extends State<ManageWalletScreen> {
  ManageWalletBloc? bloc;
  bool isLoading = true;
  List<TransactionHistory>? transactions;
  WalletDashboardModel? walletDetails;
  String amountTobeAdded = "0";
  TextEditingController amountController = TextEditingController();
  List<DropdownMenuItem<String>> accountList = [];
  @override
  void initState() {
    super.initState();
    bloc = context.read<ManageWalletBloc>()..add(GetWalletDetailsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(Utils.getStringValue(context, AppStringConstant.manageWallet), context),
      body: BlocBuilder<ManageWalletBloc, ManageWalletStates>(
        builder: (context, state) {
          if(state is ManageWalletInitialState){

          }else if(state is ManageWalletScreenLoadingState){
            isLoading = true;
          }else if(state is ManageWalletScreenErrorState){
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AlertMessage.showSuccess(state.message, context);
            });
          }
          else if(state is AddMoneyToWalletSuccessState) {
            isLoading = false;
            if(state.model?.success ?? true) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showSuccess(state.model?.message ?? "", context);
                amountController.clear();
                amountTobeAdded = "0";
                bloc?.add(GetWalletDetailsEvent());
              });
            }else{
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                AlertMessage.showError(state.model?.message ?? "", context);
              });
            }
          }
          else if(state is GetWalletDashboardDataState){
            isLoading = false;
            walletDetails = state.model;
            accountList.clear();
            accountList = addAccountDetails((walletDetails?.accountDetails ?? []));
          }
          else if(state is ViewTransactionSuccessState) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(context: context, builder: (_) => showTransactionDetails(context, state.model?.transactionData),);
            });
          }
          bloc?.emit(ManageWalletInitialState());
          return Stack(
            children: [
              buildUI(),
              isLoading?const Center(child: Loader(),):const SizedBox()
            ],
          );
        },
      ),
    );
  }
  Widget buildUI(){
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          walletDashboardView(context, walletDetails, true, onTextEditing: (value) {
            amountTobeAdded = value;
          }, onTap: (){
            if((amountTobeAdded ?? "0" ) == "0"){
              AlertMessage.showError(AppStringConstant.addAmountMsg, context);
            }else{
              bloc?.add(AddAmountToCartEvent(walletDetails?.walletProductId ?? 0, amountTobeAdded));
            }
          }, controller: amountController),
          if(walletDetails != null)...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                onPressed: (){
                  showDialog(context: context, builder: (_) {
                    return TransferAmountToBankView(accountList: accountList, callBack: (amount, accountId, note){
                      bloc?.add(TransferAmountToBankEvent(int.parse(amount), accountId, note??""));
                      Navigator.of(_).pop();
                    },);
                  },);
                },
                title: Utils.getStringValue(context, AppStringConstant.transferAmtToBank),
                kFillColor: AppColors.gold,
                // child: Text(Utils.getStringValue(context, AppStringConstant.transferAmtToBank)),
              ),
            ),
          ],
          const SizedBox(
            height: 10,
          ),
          Container(
            width: AppSizes.deviceWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            color: Theme.of(context).cardColor,
              child: Text(Utils.getStringValue(context, AppStringConstant.lastTransaction),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16
                  ),)
          ),
          transactionHistoryDetailView(context, (walletDetails?.transactionList?? []), (value) {
            bloc?.add(GetTransactionDetails(value.viewId ?? 0));
          }),
        ],
      ),
    );
  }
  List<DropdownMenuItem<String>> addAccountDetails(List<AccountList> list) {
    List<DropdownMenuItem<String>> payees = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        payees.add(DropdownMenuItem(
            value: (item.id ?? 0).toString(),
            child: Wrap(
              children: <Widget>[Text("${item.accountHolderName ?? ""} (${item.accountNumber ?? ""})",
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              )
              ],
            )));
      }
    }
    return payees;
  }
}



