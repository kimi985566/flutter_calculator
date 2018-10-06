import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void PressOperationCallback(Number number);

abstract class Number {
  //显示的数字
  String display;

  //抽象方法
  String apply(String original);
}

//常规数字显示
class NormalNumber extends Number {
  NormalNumber(String display) {
    this.display = display;
  }

  @override
  String apply(String original) {
    if (original == '0') {
      return display;
    } else {
      return original + display;
    }
  }
}

//带符号数字的显示，通常为负数
class SymbolNumber extends Number {
  @override
  String get display => '+/-';

  @override
  String apply(String original) {
    //查找符号的位置
    int index = original.indexOf('-');
    if (index == -1 && original != '0') {
      //显示负数
      return '-' + original;
    } else {
      //显示正数
      return original.replaceFirst(new RegExp(r'-'), '');
    }
  }
}

//小数的显示
class DecimalNumber extends Number {
  @override
  String get display => ('.');

  @override
  String apply(String original) {
    //查找小数点的对应位置
    int index = original.indexOf('.');
    if (index == -1) {
      return original + '.';
    } else if (index == original.length) {
      return original.replaceFirst(new RegExp(r'.'), '');
    } else {
      return original;
    }
  }
}

//数字按钮行
class NumberButtonLine extends StatelessWidget {
  NumberButtonLine({@required this.array, this.onPress})
      : assert(array != null);

  //传入的数字行
  final List<Number> array;

  //点击事件
  final PressOperationCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        NumberButton(
            number: array[0],
            pad: EdgeInsets.only(bottom: 4.0),
            onPress: onPress),
        NumberButton(
            number: array[1],
            pad: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            onPress: onPress),
        NumberButton(
            number: array[2],
            pad: EdgeInsets.only(bottom: 4.0),
            onPress: onPress)
      ]),
    );
  }
}

class NumberButton extends StatefulWidget {
  const NumberButton({@required this.number, @required this.pad, this.onPress})
      : assert(number != null),
        assert(pad != null);

  //对应的数字
  final Number number;

  //padding的类型 EdgeInsetsGeometry是EdgeInsets和EdgeInsetsDirectional的基类
  final EdgeInsetsGeometry pad;

  //点击事件回调
  final PressOperationCallback onPress;

  @override
  State<StatefulWidget> createState() => new NumberButtonState();
}

class NumberButtonState extends State<NumberButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: widget.pad,
      child: GestureDetector(
        onTap: () {
          if (widget.onPress != null) {
            widget.onPress(widget.number);
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
          color: pressed ? Colors.grey[200] : Colors.white,
          child: Text(
            '${widget.number.display}',
            style: TextStyle(fontSize: 30.0, color: Colors.grey),
          ),
        ),
      ),
    ));
  }
}
