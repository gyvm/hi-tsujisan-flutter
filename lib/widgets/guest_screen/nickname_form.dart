// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../common/h2text.dart';
import '../../common/hexcolor.dart';
import '../../model/guest_model.dart';

class NicknameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: _nicknameContainer(context),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, bottom: 0, top: 0, right: 32),
            child: _commentContainer(context),
          ),
        ],
      ),
    );
  }

  Widget _nicknameContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        // color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: 'ニックネームを入力してください'),
        ),
        Form(
          child: TextFormField(
            maxLength: 30,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#F4EFED'),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
              hintText: '例) 山田 / ささき / wada',
            ),
            cursorColor: HexColor('#8A5C46'),
            onChanged: (text) {
              if (text.length > 0) {
                var guest = context.read<GuestModel>();
                guest.nickname = text;
              } else {}
            },
          ),
        ),
      ]),
    );
  }

  Widget _commentContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
      // constraints: BoxConstraints.tightFor(height: 150),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        // color: HexColor('#F4EFED'),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: H2Text(text: 'コメントを入力してください(オプション)'),
        ),
        Form(
          child: TextFormField(
            maxLines: 8,
            maxLength: 500,
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#F4EFED'),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#8A5C46'), width: 2.0),
              ),
              hintText: '''例)
09日は17時以降なら可能です
27日も調整できる。
みんなに合わせます!!
肉が食べたい''',
            ),
            cursorColor: HexColor('#8A5C46'),
            onChanged: (text) {
              if (text.length > 0) {
                var guest = context.read<GuestModel>();
                guest.comment = text;
              } else {}
            },
          ),
        ),
      ]),
    );
  }
}
