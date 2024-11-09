
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/base_model.dart';
import 'dart:io';
import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_tool_bar.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';
import '../bloc/qr_screen_bloc.dart';
import '../bloc/qr_screen_events.dart';
import '../bloc/qr_screen_state.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  bool isLoading = false;
  QrScreenBloc? qrScreenBloc;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController _qrController;
  var mBarCode = "";
  bool helpShowed = true;
  BaseModel? baseModel;
  String? _scanBarcode = 'Unknown';





  @override
  void dispose() {
    super.dispose();
    mBarCode = "";
    helpShowed = false;
    _qrController?.dispose();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      setState(() {
        print("========>${barcodeScanRes.toString()}");
        var barCodedata = barcodeScanRes.replaceAll(" ", "+");
        print("+++++=====${barCodedata}");
        qrScreenBloc?.add(QrScanSuccessEvent(barCodedata ?? ""));
      });
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Getting an Error..';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }



  @override
  void initState() {
    helpShowed = false;
    qrScreenBloc = context.read<QrScreenBloc>();
    qrScreenBloc?.add(QrScreenDataFetchEvent());
    scanQR();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appToolBar(
            Utils.getStringValue(context, AppStringConstant.qrScan),
            context),
        body: BlocBuilder<QrScreenBloc, QrScreenState>(
            builder: (context, currentState) {
              if (currentState is QrScreenInitial) {
                  isLoading = true;
              } else if (currentState is QrScreenSuccess) {
                isLoading = false;
              } else if(currentState is QrScanScreen){
                isLoading = false;
                print("=========${currentState.response.message}");
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showSuccess(currentState.response.message ?? "", context);
                  Navigator.pop(context);
                });
              } else if(currentState is QrScreenError){
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showError(currentState.message ?? "", context);
                  Navigator.pop(context);
                });
              }
              else if (currentState is QrScreenEmptyState) {}
              qrScreenBloc?.emit(QrScreenEmptyState());
              return _buildUI();
            }),
       );
  }

  Widget _buildUI(){
    return Stack(
      children: [
        Center(
          child: Text(
            Utils.getStringValue(
                context, AppStringConstant.watchLoginProcessing),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: AppSizes.textSizeLarge),
          ),
        ),
        Center(
          child: Visibility(
            child: Loader(),
            visible: isLoading,
          ),
        )
      ],
    );
  }

}
