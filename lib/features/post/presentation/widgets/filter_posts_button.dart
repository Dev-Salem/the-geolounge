import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/presentation/controller/fetch_post_controller.dart';

class FilterPostsButton extends ConsumerStatefulWidget {
  const FilterPostsButton({super.key});

  @override
  ConsumerState<FilterPostsButton> createState() => _FilterPostsButtonState();
}

class _FilterPostsButtonState extends ConsumerState<FilterPostsButton> {
  List<bool> _selectedButton = [true, false];
  void _setSelectedButton(int index) {
    setState(() {
      final isLocalSelected =
          ref.read(fetchPostProvider.notifier).changePostsLocality();
      _selectedButton = [isLocalSelected, !isLocalSelected];
      final currentLounge = isLocalSelected ? 'Local' : 'Global';
      context.snackBar('Switched to the $currentLounge Lounge');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      renderBorder: false,
      borderRadius: BorderRadius.circular(0),
      isSelected: _selectedButton,
      onPressed: _setSelectedButton,
      children: const [
        Icon(
          FontAwesomeIcons.mapPin,
          size: 15,
        ),
        Icon(
          FontAwesomeIcons.globe,
          size: 15,
        ),
      ],
    );
  }
}
