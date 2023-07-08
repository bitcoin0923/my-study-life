import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';

class SelectColorCard extends ConsumerWidget {
  final Color selectionColor;
  final bool selected;
  final int cardIndex;
  final Function cardselected;

  const SelectColorCard(this.selectionColor, this.selected, this.cardIndex, this.cardselected, {super.key});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return InkWell(
      onTap: _cardTapped,
      child: Container(
        height: 58,
        width: 58,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(29),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 54, 
          width: 54,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 4,
              color: selected
                  ? theme == ThemeMode.dark
                      ? Constants.darkThemePrimaryColor
                      : Colors.black
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(27),
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: selectionColor,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
