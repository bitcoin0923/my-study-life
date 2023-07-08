import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import './profile_personalization_card.dart';
import '../../Models/profile_datasource.dart';

class EditList extends ConsumerWidget {
  final Function cardselected;
  final List<ProfileItemStatic> _items;
  EditList(this.cardselected, this._items, {super.key});

  void _selectedEditCard(int index) {
    cardselected(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      alignment: Alignment.topCenter,
      height: 140,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ProfilePersonalizationCard(
              cardIndex: index,
              cardselected: _selectedEditCard,
              title: _items[index].title);
        },
      ),
    );
  }
}
