import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/common/styles.dart';

class TextFieldSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        decoration: InputDecoration(
          labelText: 'Search',
          suffixIcon: Icon(
            Icons.search,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
        ),
      ),
    );
  }
}
