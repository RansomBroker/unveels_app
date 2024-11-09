//
// /*
//  *
//
//
//  *
//  * /
//  */
//
// import 'dart:io';
//
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:test_new/unvells/helper/app_storage_pref.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:test_new/unvells/screens/deliverboy_admin_chat/widgets/sender_chat_text_item_widget.dart';
// import '../../../../unvells/app_widgets/app_bar.dart';
// import '../../../../unvells/constants/app_constants.dart';
// import '../../../../unvells/constants/app_string_constant.dart';
// import '../../../../unvells/helper/app_localizations.dart';
// import '../../../../unvells/helper/utils.dart';
// import '../../../app_widgets/app_alert_message.dart';
// import '../../../helper/push_notifications_manager.dart';
// import '../../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
// import '../../../models/help_admin_chat_model/help_chat_message_model.dart';
// import '../bloc/deliveryboy_help_chat_bloc.dart';
// import '../bloc/deliveryboy_help_chat_event.dart';
// import '../bloc/deliveryboy_help_chat_screen_state.dart';
//
// class DeliveryboyHelpChatScreen extends StatefulWidget {
//  final  AssignedDeliveryBoyDetails deliveryBoyData;
//    DeliveryboyHelpChatScreen(this.deliveryBoyData,{Key? key,}) : super(key: key);
//
//   @override
//   State<DeliveryboyHelpChatScreen> createState() => _DeliveryboyHelpChatScreenState();
// }
//
// class _DeliveryboyHelpChatScreenState extends State<DeliveryboyHelpChatScreen> {
//
//
//   TextEditingController messageController = TextEditingController();
//   AppLocalizations? _localizations;
//   // FirebaseDatabase? firebaseDatabase;
//   // DatabaseReference? databaseReference;
//
//   String avatar = "";
//   String userId = "";
//   String userName = "";
//   String mSellerId = "";
//
//   String mAccountType = "";
//   String mUserId = "";
//   String name = "";
//   String? time;
//   DeliveryboyHelpChatBloc? _deliveryboyHelpChatBloc;
//   bool isLoading = false;
//
//   @override
//   void didChangeDependencies() {
//     _localizations = AppLocalizations.of(context);
//     super.didChangeDependencies();
//   }
//
//   @override
//   void initState() {
//     avatar = widget.deliveryBoyData.avatar.toString();
//     userId = widget.deliveryBoyData.customerId.toString();
//     userName = widget.deliveryBoyData.name.toString();
//     mSellerId = widget.deliveryBoyData.sellerId.toString();
//     _deliveryboyHelpChatBloc = context.read<DeliveryboyHelpChatBloc>();
//
//
//     mAccountType = "customer";
//     mUserId = "customer-${widget.deliveryBoyData.customerId}+owner-${widget.deliveryBoyData.sellerId}";
//     //customer-+owner-1
//
//     print("USER-ID===> ${userId}");
//     print("USER-Name===> ${userName}");
//     Firebase.initializeApp();
//     final FirebaseApp app = Firebase.app();
//     firebaseDatabase = FirebaseDatabase.instance;
//     firebaseDatabase?.app = app;
//     firebaseDatabase?.databaseURL = ApiConstant.firebaseUrl;
//     databaseReference = firebaseDatabase
//         ?.refFromURL(ApiConstant.firebaseUrl)
//         .child("DeliveryApp")
//         .child("messages")
//         .child(mAccountType)
//         .child(mUserId);
//     _deliveryboyHelpChatBloc?.add(UpdateTokenEvent("customer-${widget.deliveryBoyData.customerId ?? ""}", userName, avatar, mAccountType, Platform.isAndroid? "android" : "iOS", mSellerId));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).cardColor,
//       appBar: commonAppBar(
//           Utils.getStringValue(context,  "Admin" ), context,
//
//       ),
//       body: BlocBuilder<DeliveryboyHelpChatBloc, DeliveryboyHelpChatState>(
//           builder: (context, currentState) {
//             if (currentState is SellerListInitial) {
//               isLoading = true;
//             } else if (currentState is UpdateTokenSuccessState) {
//               isLoading = false;
//             // _deliveryboyHelpChatBloc?.emit(SellerListMpEmpty());
//             } else if (currentState is UpdateTokenErrorState) {
//               isLoading = false;
//               WidgetsBinding.instance?.addPostFrameCallback((_) {
//                 AlertMessage.showError(currentState.message, context);
//               });
//             }
//             return buildUi();
//           }),
//     );
//   }
//
//   Widget buildUi() {
//     return Column(
//       children: [
//         Expanded(child: buildChatUi()),
//        // buildBottomView()
//       ],
//     );
//   }
//
//   Widget buildChatUi() {
//     return StreamBuilder(
//         stream: databaseReference?.orderByChild('timestamp').onValue,
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             print("snapshotData--->${snapshot.data}");
//             List<HelpChatMessageModel> messageList = [];
//             if (snapshot.data.snapshot.value != null) {
//               Map<dynamic, dynamic> msgs = snapshot.data.snapshot.value;
//               print("Messages${msgs}");
//               List getMessages = msgs.values.toList();
//               getMessages.sort((a, b) {
//                 return b["timestamp"]
//                     .toString()
//                     .compareTo(a["timestamp"].toString());
//               });
//               for (var value in getMessages) {
//                 messageList.add(HelpChatMessageModel(
//                     id: value["id"],
//                     name: value["name"],
//                     msg: value["msg"],
//                     timestamp: value["timestamp"].toString()));
//               }
//
//               return Column(
//                 children: [
//                   Expanded(
//                       child: ListView.builder(
//                           reverse: true,
//                           itemCount: messageList?.length,
//                           itemBuilder: (BuildContext context,int index){
//                             time = formatTimestamp(int.tryParse(messageList?[index].timestamp ?? "") ?? 0);
//                           return commonChatWidget(context, userName, messageList?[index]?.msg, time,messageList[index], widget.deliveryBoyData.customerId!
//                           );
//
//                       })
//                   ),
//                   buildBottomView(),
//                   const SizedBox(width: AppSizes.spacingNormal,),
//                 ],
//               );
//             } else {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: Center(
//                         child: Text(
//                             _localizations?.translate(
//                                 AppStringConstant.startConversation) ??
//                                 "",
//                             style: Theme.of(context).textTheme.bodyLarge)),
//                   ),
//                   buildBottomView(),
//                   const SizedBox(width: AppSizes.spacingNormal,),
//                 ],
//               );
//             }
//           } else {
//             return Center(
//                 child: Text(
//                     _localizations?.translate("${AppStringConstant.pleaseWait}....") ??
//                         "",
//                     style: Theme.of(context).textTheme.bodyLarge));
//           }
//         });
//   }
//
//   Widget buildBottomView(){
//     return  Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         const SizedBox(width: AppSizes.spacingGeneric,),
//         SizedBox(
//             width: AppSizes.deviceWidth/1.2,
//             child: TextField(
//               controller: messageController,
//               maxLines: 20,
//               minLines: 1,
//               obscureText: false,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
//               decoration: InputDecoration(
//                 hintText: 'Type Your Message Here',
//                 isDense: true,
//                 contentPadding: const EdgeInsets.all(15),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppSizes.spacingLarge),
//                     borderSide:
//                     const BorderSide(color: AppColors.darkGray, width: 0)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppSizes.spacingLarge),
//                     borderSide:
//                     const BorderSide(color: AppColors.darkGray, width: 0)),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppSizes.spacingLarge),
//                     borderSide:
//                     const BorderSide(color: AppColors.darkGray, width: 0)),
//                 filled: true,
//               ),
//             )),
//         IconButton(
//             onPressed: sendChat,
//             icon:  Icon(
//               Icons.send,
//               color: Theme.of(context).colorScheme.outline,
//               size: 31,
//             )),
//       ],
//     );
//   }
//
//   String formatTimestamp(int timestamp) {
//     var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
//     var formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(date);
//     print(DateFormat('yyyy-MM-dd hh:mm').format(date));
//     print(date);
//     return formattedDate;
//   }
//
//   Future<void> sendChat() async {
//     Map<String, Object> body = {};
//     if (messageController.text.trim() != "") {
//       body["id"] = "customer-${widget.deliveryBoyData.customerId}";
//       body["name"] = /*appStoragePref.isAdmin() ? ("Admin") : */appStoragePref.getUserData()?.name ?? "";
//       // body["name"] = "Admin";
//       body["msg"] = messageController.text.trim();
//       body["timestamp"] = ServerValue.timestamp;
//       print("body---->$body");
//       databaseReference?.push().set(body);
//       setState(() {
//         messageController.clear();
//       });
//     }
//     print("--->Send Button Clicked");
//   }
// }
