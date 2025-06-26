import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBarWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Pesquisar...',
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
