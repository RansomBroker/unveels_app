import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unveels_tech_evorty/shared/configs/asset_path.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_choose_button.dart';
import 'package:test_new/unvells/constants/app_routes.dart';

class VaChooseConnection extends StatelessWidget {
  const VaChooseConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 49, 13, 207),
            child: Column(
              children: [
                const Header(),
                const SizedBox(height: 31),
                const Text(
                  'How would you like to communicate with me today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                OptionCard(
                  title: 'Vocal Connection',
                  description:
                      'Speak freely, and I\'ll respond in real-time. Let\'s talk Speech to Speech!',
                  iconPath: IconPath.speakerSubwoofer,
                  buttonText: 'Start Video Chat',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                OptionCard(
                  title: 'Text Connection',
                  description:
                      'Prefer typing? Chat with me directly using text. I\'m here to help!',
                  iconPath: IconPath.messagesChat,
                  buttonText: 'Start Text Chat',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.vaTextConnection);
                  },
                ),
                const SizedBox(height: 15),
                OptionCard(
                  title: 'Audible Assistance',
                  description:
                      'Type your thoughts, and I\'ll reply with a voice. Enjoy a hands-free experience.',
                  iconPath: IconPath.userProfileVoice,
                  buttonText: 'Start Audio Response',
                  onPressed: () {},
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
  final VoidCallback onPressed;

  const OptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(202, 156, 67, 0.2),
            Color.fromRGBO(145, 110, 43, 0.15),
            Color.fromRGBO(106, 79, 27, 0.1),
            Color.fromRGBO(71, 50, 9, 0.1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: -4,
          ),
        ],
      ),
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
              const SizedBox(width: 8),
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
              child: VaChooseButton(
                buttonText: buttonText, onPressed: onPressed))
        ],
      ),
    );
  }
}
