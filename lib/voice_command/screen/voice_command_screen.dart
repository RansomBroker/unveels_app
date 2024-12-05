import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/voice_command_cubit.dart';

class VoiceCommandScreen extends StatefulWidget {
  final Widget child;

  const VoiceCommandScreen({
    super.key,
    required this.child,
  });

  @override
  State<VoiceCommandScreen> createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: widget.child,
          ),
          BlocBuilder<VoiceCommandCubit, VoiceCommandState>(
            builder: (context, state) {
              if (state is VoiceCommandListening) {
                return Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 4,
                    child: LinearProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
