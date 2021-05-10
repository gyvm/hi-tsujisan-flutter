import 'package:flutter/material.dart';

import '../../common/h2text.dart';
import '../../common/hexcolor.dart';

class NicknameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: _nicknameContainer(),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, bottom: 0, top: 0, right: 32),
            child: _commentContainer(),
          ),
        ],
      ),
    );
  }

  Widget _nicknameContainer() {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        H2Text(text: 'ニックネームを入力してください'),
        Form(
          child: TextFormField(
            maxLength: 30,
            cursorColor: HexColor('#8A5C46'),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // hintText: "",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
            ),
            onChanged: (text) {
              if (text.length > 0) {
              } else {}
            },
          ),
        ),
      ]),
    );
  }

  Widget _commentContainer() {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      // constraints: BoxConstraints.tightFor(height: 150),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        H2Text(text: 'コメントを入力してください(オプション)'),
        Form(
          child: TextFormField(
            maxLines: 8,
            maxLength: 500,
            cursorColor: HexColor('#8A5C46'),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "例：○○は20時以降なら可能です。",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
            ),
            onChanged: (text) {
              if (text.length > 0) {
              } else {}
            },
          ),
        ),
      ]),
    );
  }
}
