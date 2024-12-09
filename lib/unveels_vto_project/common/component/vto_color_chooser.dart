import 'package:flutter/material.dart';
import 'package:test_new/unveels_vto_project/common/helper/constant.dart';

class VtoColorChooser extends StatelessWidget {
  final List<Color> colorChoiceList;
  final List<Color>? selectedColors;
  final Function(Color) onColorSelected;
  final Function? onClear;

  const VtoColorChooser({
    super.key,
    required this.colorChoiceList,
    this.selectedColors,
    required this.onColorSelected,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                if (onClear != null) {
                  onClear!();
                }
              },
              child: const Icon(
                Icons.do_not_disturb_alt_sharp,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: colorChoiceList.length,
                separatorBuilder: (_, __) => Constant.xSizedBox12,
                itemBuilder: (context, index) {
                  Color color = colorChoiceList[index];
                  return InkWell(
                    onTap: () async {
                      onColorSelected(color);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selectedColors?.contains(color) == true
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: colorChoiceList[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
