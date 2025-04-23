import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController textEditingController;

  const SearchBar({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
    );
  }
}
