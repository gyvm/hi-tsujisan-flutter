// Dart imports:
import 'dart:html';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../common/hexcolor.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              // minWidth: 0,
              // minHeight: 0,
              maxWidth: 520,
              maxHeight: double.infinity,
            ),
            child: Column(
              children: [
                OnboardingTextPadding(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'こんにちは👋これは日程調整の',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '執事',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#8A5C46'),
                          ),
                        ),
                        TextSpan(
                          text: 'アプリです',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                OnboardingTextPadding(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '3',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#8A5C46'),
                          ),
                        ),
                        TextSpan(
                          text: 'ステップでかんたんに予定を立てましょう',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      // minWidth: 0,
                      // minHeight: 0,
                      maxWidth: 370,
                      maxHeight: double.infinity,
                    ),
                    child: Column(children: [
                      OnboardingText(
                          text: '1 ', text2: 'イベント名と日程を入力してイベントを作成！'),
                      OnboardingText(text: '2 ', text2: 'イベントのURLを共有して参加日を入力！'),
                      OnboardingText(text: '3 ', text2: 'イベント日が決定！'),
                    ])),
              ],
            )));
  }
}

class OnboardingText extends StatelessWidget {
  OnboardingText({
    Key key,
    this.text,
    this.text2,
  }) : super(key: key);

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#8A5C46'),
                ),
              ),
              TextSpan(
                text: text2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }
}

class OnboardingTextPadding extends StatelessWidget {
  OnboardingTextPadding({Key key, this.child}) : super(key: key);

  final child;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 20), child: child));
  }
}
