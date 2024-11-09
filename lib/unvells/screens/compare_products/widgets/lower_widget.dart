/*
 *


 *
 * /
 */

// import 'dart:collection';
// import 'package:flutter/material.dart';
//
// class LowerWidgets extends StatefulWidget {
//   final CompareProductModel compareProductModel;
//   final LinkedScrollControllerGroup _controllers;
//
//   LowerWidgets(this.compareProductModel, this._controllers);
//
//   @override
//   _LowerWidgetsState createState() => _LowerWidgetsState();
// }
//
// class _LowerWidgetsState extends State<LowerWidgets> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.compareProductModel.productItemData.compare_data != null
//         ? _getCompareProductData(widget.compareProductModel.productItemData.compare_data)
//         : Container();
//   }
//
//   _getCompareProductData(LinkedHashMap compare_dataBean) {
//     List<Widget> list = List();
//
//     widget.compareProductModel.productItemData.compare_data
//         .forEach((key, value) {
//       list.add(Divider(
//         thickness: 1,
//       ));
//       list.add(Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//         key,
//         style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
//             ),
//           ),
//         ),
//       ));
//       value.forEach((key, value) {
//         ScrollController controller = widget._controllers.addAndGet();
//         list.add(MyAttributeView(key, widget.compareProductModel));
//         list.add(
//           Container(
//             height: 50,
//             alignment: Alignment.topLeft,
//             child: TableHead(
//               scrollController: controller,
//               textData: value,
//               compareProductModel: widget.compareProductModel,
//               productItems:
//                   widget.compareProductModel.productItemData.products.length,
//             ),
//           ),
//         );
//       });
//     });
//
//     return Wrap(
//       alignment: WrapAlignment.end,
//       spacing: 10,
//       children: list,
//     );
//   }
// }
