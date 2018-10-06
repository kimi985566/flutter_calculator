import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void PressOperationCallback(Operator operator);

abstract class Operator {
  //显示结果
  String display;

  //颜色
  Color color;

  //计算结果，数字
  num calculate(num first, num second);
}

//加法运算
class AddOperation extends Operator {
  @override
  String get display => '+';

  @override
  Color get color => Colors.red[300];

  @override
  num calculate(num first, num second) {
    return first + second;
  }
}

//减法运算
class SubOperation extends Operator {
  @override
  String get display => '-';

  @override
  Color get color => Colors.orange[300];

  @override
  num calculate(num first, num second) {
    return first - second;
  }
}

//乘法操作
class MultiOperation extends Operator {
  @override
  String get display => 'x';

  @override
  Color get color => Colors.blue[300];

  @override
  calculate(first, second) {
    return first * second;
  }
}

//除法操作
class DivisionOperation extends Operator {
  @override
  String get display => '÷';

  @override
  Color get color => Colors.purple[300];

  @override
  calculate(first, second) {
    return first / second;
  }
}

class OperatorGroup extends StatelessWidget {
  OperatorGroup(this.onOperatorButtonPressed);

  final PressOperationCallback onOperatorButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OperatorButton(
          operator: AddOperation(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          operator: SubOperation(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          operator: MultiOperation(),
          onPress: onOperatorButtonPressed,
        ),
        OperatorButton(
          operator: DivisionOperation(),
          onPress: onOperatorButtonPressed,
        ),
      ],
    );
  }
}

class OperatorButton extends StatefulWidget {
  OperatorButton({@required this.operator, this.onPress})
      : assert(Operator != null);
  final Operator operator;
  final PressOperationCallback onPress;

  @override
  State<StatefulWidget> createState() => OperatorButtonState();
}

class OperatorButtonState extends State<OperatorButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          if (widget.onPress != null) {
            widget.onPress(widget.operator);
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
            color: pressed
                ? Color.alphaBlend(Colors.white30, widget.operator.color)
                : widget.operator.color,
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
          child: Text(
            '${widget.operator.display}',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ),
      ),
    ));
  }
}
