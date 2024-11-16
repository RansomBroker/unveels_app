import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unveels_tech_evorty/shared/configs/asset_path.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_choose_button.dart';

class VaChooseConnection extends StatelessWidget {
  const VaChooseConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(13, 49, 13, 207),
            child: Column(
              children: [
                Header(),
                SizedBox(height: 31),
                Text(
                  'How would you like to communicate with me today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                OptionCard(
                  title: 'Vocal Connection',
                  description:
                      'Speak freely, and I\'ll respond in real-time. Let\'s talk Speech to Speech!',
                  iconPath: IconPath.speakerSubwoofer,
                  buttonText: 'Start Video Chat',
                ),
                SizedBox(height: 15),
                OptionCard(
                  title: 'Text Connection',
                  description:
                      'Prefer typing? Chat with me directly using text. I\'m here to help!',
                  iconPath: IconPath.messagesChat,
                  buttonText: 'Start Text Chat',
                ),
                SizedBox(height: 15),
                OptionCard(
                  title: 'Audible Assistance',
                  description:
                      'Type your thoughts, and I\'ll reply with a voice. Enjoy a hands-free experience.',
                  iconPath: IconPath.userProfileVoice,
                  buttonText: 'Start Audio Response',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.pause_circle,
                size: 24, color: Colors.white),
            const SizedBox(width: 17),
            Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 17),
            const Text(
              '00:00',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 17),
            const Icon(CupertinoIcons.stop_circle,
                size: 24, color: Colors.white),
            const SizedBox(width: 20),
          ],
        ),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon:
                const Icon(CupertinoIcons.clear, size: 30, color: Colors.white))
      ],
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final String buttonText;

  const OptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 255, 217, 0),
              spreadRadius: 0,
            ),
            BoxShadow(color: Color.fromARGB(255, 0, 0, 0), blurRadius: 30),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 9),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
                width: double.infinity,
                child:
                    VaChooseButton(buttonText: buttonText, onPressed: () {})),
          ],
        ),
      ),
    );
  }
}
