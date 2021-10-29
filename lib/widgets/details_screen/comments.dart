// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/date_symbol_data_http_request.dart';

// Project imports:
import 'package:hi_tsujisan_frontend/common/h2text.dart';
import 'package:hi_tsujisan_frontend/common/hexcolor.dart';

class Comments extends StatelessWidget {
  const Comments({Key key, @required this.guestData}) : super(key: key);

  final List<dynamic> guestData;

  @override
  Widget build(BuildContext context) {
    int commentCount = 0;
    for (int i = 0; i < guestData.length; i++) {
      if ((guestData[i]['comment'] != null) &&
          (guestData[i]['comment'].length > 0)) {
        commentCount = commentCount + 1;
      }
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: H2Text(text: 'コメント'),
          ),
          (commentCount == 0)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text('まだコメントはありません。'))
              : Container(),
          for (int i = 0; i < guestData.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: (guestData[i]['comment'] != null) &&
                      (guestData[i]['comment'].length > 0)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: guestData[i]['nickname'] + '： ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: guestData[i]['comment'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
        ],
      ),
    );
  }
}
