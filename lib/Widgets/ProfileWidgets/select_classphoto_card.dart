import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Models/subjectColors_dataosource.dart';
import '../../Utilities/constants.dart';

class SelectSubjectPhotoCard extends ConsumerWidget {
  final SubjectPhoto subjectPhoto;
  final int cardIndex;
  final Function cardselected;

  const SelectSubjectPhotoCard(
      this.subjectPhoto, this.cardIndex, this.cardselected,
      {super.key});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return InkWell(
      onTap: _cardTapped,
      child: Container(
        height: 102,
        width: 102,
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(2),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                width: 4,
                color: subjectPhoto.selected
                    ? Constants.lightThemePrimaryColor
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      subjectPhoto.imagePath ??
                          "assets/images/LockedImageIcon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (subjectPhoto.isLocked) ...[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/LockedImageIcon.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
