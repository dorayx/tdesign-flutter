/*
 * Created by haozhicao@tencent.com on 6/20/22.
 * td_dialog_widget.dart
 * 
 */

import 'package:flutter/material.dart';

import '../../../td_export.dart';
import '../../util/auto_size.dart';

class TDDialogScaffold extends StatelessWidget {
  const TDDialogScaffold({
    Key? key,
    required this.body,
    this.showCloseButton,
    this.backgroundColor = Colors.white,
    this.radius = 8.0,
  }) : super(key: key);

  final Widget body;
  final bool? showCloseButton;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320.scale,
        decoration: BoxDecoration(
          color: backgroundColor, // 底色
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Stack(
          children: [
            body,
            showCloseButton ?? false
                ? Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 30.scale,
                        height: 30.scale,
                        child: Center(
                          child: Icon(
                            TDIcons.close,
                            size: 20.scale,
                            color: TDTheme.of(context).fontGyColor3,
                          ),
                        ),
                      ),
                    ))
                : Container(height: 0)
          ],
        ),
      ),
    );
  }
}

/// 弹窗标题
class TDDialogTitle extends StatelessWidget {
  const TDDialogTitle({
    Key? key,
    this.title = '对话框标题',
    this.titleColor = Colors.black,
  }) : super(key: key);

  /// 标题颜色
  final Color titleColor;

  /// 标题文字
  final String title;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return TDText(
      title,
      textColor: titleColor,
      fontWeight: FontWeight.w600,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}

/// 弹窗内容
class TDDialogContent extends StatelessWidget {
  const TDDialogContent({
    Key? key,
    this.content = '当前弹窗内容',
    this.contentColor = const Color(0x66000000),
  }) : super(key: key);

  /// 标题颜色
  final Color contentColor;

  /// 标题文字
  final String content;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return TDText(
      content,
      textColor: contentColor,
      font: Font(size: 16, lineHeight: 24),
      textAlign: TextAlign.center,
    );
  }
}

/// 弹窗信息
class TDDialogInfoWidget extends StatelessWidget {
  const TDDialogInfoWidget({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
    this.content,
    this.contentColor,
    this.contentMaxHeight = 0,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 内容的最大高度，默认为0，也就是不限制高度
  final double contentMaxHeight;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    assert((title != null || content != null));
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title != null
              ? TDText(
                  title,
                  textColor: titleColor,
                  fontWeight: FontWeight.w600,
                  font: Font(size: 16, lineHeight: 24),
                  textAlign: TextAlign.center,
                )
              : Container(),
          content == null
              ? Container()
              : Container(
                  padding: EdgeInsets.fromLTRB(
                      0, (title != null && content != null) ? 8.0 : 0, 0, 0),
                  constraints: contentMaxHeight > 0
                      ? BoxConstraints(
                          maxHeight: contentMaxHeight,
                        )
                      : null,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TDDialogContent(
                        content: content!,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

/// 水平按钮
class HorizontalNormalButtons extends StatelessWidget {
  const HorizontalNormalButtons({
    Key? key,
    required this.leftBtn,
    required this.rightBtn,
  }) : super(key: key);

  /// 标题颜色
  final TDDialogButtonOptions leftBtn;

  /// 标题文字
  final TDDialogButtonOptions rightBtn;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TDDialogButton(
              buttonText: leftBtn.title,
              buttonTextColor:
                  leftBtn.titleColor ?? TDTheme.of(context).brandColor8,
              buttonStyle: leftBtn.style ?? TDButtonStyle.secondary(),
              height: leftBtn.height,
              buttonTextFontWeight: leftBtn.fontWeight,
              onPressed: () {
                Navigator.pop(context);
                leftBtn.action();
              },
            ),
          ),
          const TDDivider(
            width: 20,
            color: Colors.transparent,
          ),
          Expanded(
            child: TDDialogButton(
              buttonText: rightBtn.title,
              buttonTextColor:
                  rightBtn.titleColor ?? TDTheme.of(context).whiteColor1,
              buttonStyle: rightBtn.style ?? TDButtonStyle.primary(),
              height: rightBtn.height,
              buttonTextFontWeight: rightBtn.fontWeight,
              onPressed: () {
                Navigator.pop(context);
                rightBtn.action();
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 左右横向文字按钮，顶部和中间有分割线
class HorizontalTextButtons extends StatelessWidget {
  const HorizontalTextButtons({
    Key? key,
    required this.leftBtn,
    required this.rightBtn,
  }) : super(key: key);

  /// 标题颜色
  final TDDialogButtonOptions leftBtn;

  /// 标题文字
  final TDDialogButtonOptions rightBtn;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return Column(
      children: [
        const TDDivider(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TDDialogButton(
                buttonText: leftBtn.title,
                buttonTextColor:
                    leftBtn.titleColor ?? TDTheme.of(context).fontGyColor2,
                buttonStyle: leftBtn.style ?? TDButtonStyle.text(),
                height: leftBtn.height,
                buttonTextFontWeight: leftBtn.fontWeight,
                onPressed: () {
                  Navigator.pop(context);
                  leftBtn.action();
                },
              ),
            ),
            const TDDivider(
              width: 1,
              height: 56,
            ),
            Expanded(
              child: TDDialogButton(
                buttonText: rightBtn.title,
                buttonTextColor:
                    rightBtn.titleColor ?? TDTheme.of(context).brandColor8,
                buttonStyle: rightBtn.style ?? TDButtonStyle.text(),
                height: rightBtn.height,
                buttonTextFontWeight: rightBtn.fontWeight,
                onPressed: () {
                  Navigator.pop(context);
                  rightBtn.action();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

/// 弹窗标题
class TDDialogButton extends StatelessWidget {
  const TDDialogButton({
    Key? key,
    this.buttonText = '按钮',
    this.buttonTextColor,
    this.buttonTextFontWeight = FontWeight.w600,
    this.buttonStyle,
    required this.onPressed,
    this.height = 40.0,
    this.width,
  }) : super(key: key);

  /// 按钮文字
  final String? buttonText;

  /// 按钮文字颜色
  final Color? buttonTextColor;

  final FontWeight? buttonTextFontWeight;

  final TDButtonStyle? buttonStyle;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 点击
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TDButton(
      onTap: onPressed,
      style: buttonStyle ?? TDButtonStyle.primary(),
      content: buttonText,
      textStyle: TextStyle(fontWeight: FontWeight.w600, color: buttonTextColor),
      width: width,
      height: height,
    );
  }
}
