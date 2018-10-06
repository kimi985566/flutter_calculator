import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'operator.dart';

typedef void PressOperationCallback(display);

class Result {
  Result();

  //第一个数字
  String firstNum;

  //第二个数字
  String secondNum;

  //运算符号
  Operator operator;

  //结果
  num result;
}

//结果展示
class ResultDisplay extends StatelessWidget {
  ResultDisplay({this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$result',
      softWrap: false,
      overflow: TextOverflow.fade,
      textScaleFactor: 7.5 / result.length > 1.0 ? 1.0 : 7.5 / result.length,
      style: TextStyle(
          fontSize: 80.0, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

//历史记录
class HistoryBlock extends StatelessWidget {
  HistoryBlock({this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    var text = '';
    if (result.secondNum != null) {
      text =
          '${result.firstNum} ${result.operator.display} ${result.secondNum}';
    } else if (result.operator != null) {
      text = '${result.firstNum} ${result.operator.display} ?';
    } else if (result.firstNum != null) {
      text = '${result.firstNum}';
    }
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: result.operator != null
                ? result.operator.color
                : Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(100.0))),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ResultButton extends StatefulWidget {
  ResultButton({@required this.display, @required this.color, this.onPress});

  //显示的结果
  final String display;

  //模块的颜色
  final Color color;

  //点击事件
  final PressOperationCallback onPress;

  @override
  State<StatefulWidget> createState() => ResultButtonState();
}

class ResultButtonState extends State<ResultButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 18.0),
            child: GestureDetector(
              onTap: () {
                if (widget.onPress != null) {
                  widget.onPress(widget.display);
                  setState(() {
                    pressed = true;
                  });
                  Future.delayed(
                      const Duration(milliseconds: 200),
                      () => setState(() {
                            pressed = false;
                          }));
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: pressed ? Colors.grey[200] : null,
                    border: Border.all(color: widget.color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Text(
                  '${widget.display}',
                  style: TextStyle(
                      fontSize: 36.0,
                      color: widget.color,
                      fontWeight: FontWeight.w300),
                ),
              ),
            )));
  }
}
