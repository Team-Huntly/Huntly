import 'dart:math';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huntly/core/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:animate_icons/animate_icons.dart';

import '../../../huntsCreate/presentation/pages/hunt_edit_page.dart';
import '../pages/presets_page.dart';

class DraggableSpeedDialButton extends StatefulWidget {
  DraggableSpeedDialButton(
      {Key? key,
      this.rePosition,
      this.url,
      this.fromIndexPage = false,
      required this.outerContext})
      : super(key: key);

  final VoidCallback? rePosition;
  final String? url;
  final bool fromIndexPage;
  final BuildContext outerContext;

  @override
  State<StatefulWidget> createState() => _DraggableSpeedDialButtonState();
}

class _DraggableSpeedDialButtonState extends State<DraggableSpeedDialButton> {
  Size? _widgetSize;
  double? _left, _top;
  late double _screenWidth, _screenHeight;
  double? _screenWidthMid, _screenHeightMid;
  double _fabSize = 60;
  double _appBarSize = AppBar().preferredSize.height + 20;
  late double _h;
  late double _w;

//  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _h = MediaQuery.of(context).size.height;
      _w = MediaQuery.of(context).size.width;
      _getWidgetSize(context);
      _top = widget.fromIndexPage
          ? _h - (_fabSize + kBottomNavigationBarHeight)
          : _h - (_fabSize);
      _left = _w - _fabSize;
    });
  }

  void _getWidgetSize(BuildContext context) {
    _widgetSize = context.size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: _left,
            top: _top,
            child: Draggable(
              child: GestureDetector(
                child: DrabbleSpeedDial(
                  outerContext: widget.outerContext,
                  url: widget.url,
                  switchLabel: _left != null && _left! < _w / 2,
                ),
                onTap: () {},
                onDoubleTap: () {
                  setState(() {
                    this._top = widget.fromIndexPage
                        ? _h - (_fabSize + kBottomNavigationBarHeight)
                        : _h - (_fabSize);
                    this._left = _w - _fabSize;
                  });
                },
              ),

              ///Re-position
//          DrabbleSpeedDial(
//            visible: _visible,
//            onPressed: () {
//              setState(() {
//                this._left = _screenWidth - 150;
//                this._top = _screenHeight - 300;
//              });
//            },
//          ),
              feedback: DrabbleSpeedDial(
                outerContext: widget.outerContext,
              ),
              childWhenDragging: Container(),
              onDragEnd: _handleDragEnded,
            ))
      ],
    );
  }

  void _handleDragEnded(DraggableDetails draggableDetails) {
//    setState(() {
//      _visible = true;
//    });
    if (_screenWidthMid == null || _screenHeightMid == null) {
      Size screenSize = MediaQuery.of(context).size;
      _screenWidth = screenSize.width;
      _screenHeight = screenSize.height;
      _screenWidthMid = _screenWidth / 2;
      _screenHeightMid = _screenHeight / 2;
    }

    switch (_getAnchor(draggableDetails.offset)) {
      case Anchor.LEFT_FIRST:
        this._left = _widgetSize!.width / 2;
        this._top = max(
            _widgetSize!.height / 2 + _appBarSize, draggableDetails.offset.dy);
        break;
      case Anchor.TOP_FIRST:
        this._left = max(_widgetSize!.width / 2, draggableDetails.offset.dx);
        this._top = _widgetSize!.height / 2 + _appBarSize;
        break;
      case Anchor.RIGHT_SECOND:
        this._left = _screenWidth - _widgetSize!.width;
        this._top =
            max(_widgetSize!.height + _appBarSize, draggableDetails.offset.dy);
        break;
      case Anchor.TOP_SECOND:
        this._left =
            min(_screenWidth - _widgetSize!.width, draggableDetails.offset.dx);
        this._top = _widgetSize!.height / 2 + _appBarSize;
        break;
      case Anchor.LEFT_THIRD:
        this._left = _widgetSize!.width / 2;
        this._top = widget.fromIndexPage
            ? min(
                _screenHeight -
                    _widgetSize!.height -
                    kBottomNavigationBarHeight,
                draggableDetails.offset.dy)
            : min(_screenHeight - _widgetSize!.height,
                draggableDetails.offset.dy);
        break;
      case Anchor.BOTTOM_THIRD:
        this._left = max(_widgetSize!.width / 2, draggableDetails.offset.dx);
        this._top = widget.fromIndexPage
            ? _screenHeight - _widgetSize!.height - kBottomNavigationBarHeight
            : _screenHeight - _widgetSize!.height;
        break;
      case Anchor.RIGHT_FOURTH:
        this._left = _screenWidth - _widgetSize!.width;
        this._top = widget.fromIndexPage
            ? min(
                _screenHeight -
                    _widgetSize!.height -
                    kBottomNavigationBarHeight,
                draggableDetails.offset.dy)
            : min(_screenHeight - _widgetSize!.height,
                draggableDetails.offset.dy);
        break;
      case Anchor.BOTTOM_FOURTH:
        this._left =
            min(_screenWidth - _widgetSize!.width, draggableDetails.offset.dx);
        this._top = widget.fromIndexPage
            ? _screenHeight - _widgetSize!.height - kBottomNavigationBarHeight
            : _screenHeight - _widgetSize!.height;
        break;
    }

    setState(() {});
  }

  Anchor _getAnchor(Offset position) {
    if (position.dx < _screenWidthMid! && position.dy < _screenHeightMid!) {
      return position.dx < position.dy ? Anchor.LEFT_FIRST : Anchor.TOP_FIRST;
    } else if (position.dx >= _screenWidthMid! &&
        position.dy < _screenHeightMid!) {
      return _screenWidth - position.dx < position.dy
          ? Anchor.RIGHT_SECOND
          : Anchor.TOP_SECOND;
    } else if (position.dx < _screenWidthMid! &&
        position.dy >= _screenHeightMid!) {
      return position.dx < _screenHeight - position.dy
          ? Anchor.LEFT_THIRD
          : Anchor.BOTTOM_THIRD;
    } else {
      return _screenWidth - position.dx < _screenHeight - position.dy
          ? Anchor.RIGHT_FOURTH
          : Anchor.BOTTOM_FOURTH;
    }
  }
}

/// #######################################
/// #       |          #        |         #
/// #    TOP_FIRST     #  TOP_SECOND      #
/// # - LEFT_FIRST     #  RIGHT_SECOND -  #
/// #######################################
/// # - LEFT_THIRD     #   RIGHT_FOURTH - #
/// #  BOTTOM_THIRD    #   BOTTOM_FOURTH  #
/// #     |            #       |          #
/// #######################################

enum Anchor {
  LEFT_FIRST,
  TOP_FIRST,
  RIGHT_SECOND,
  TOP_SECOND,
  LEFT_THIRD,
  BOTTOM_THIRD,
  RIGHT_FOURTH,
  BOTTOM_FOURTH
}

class DrabbleSpeedDial extends StatefulWidget {
  final String? url;
  final bool switchLabel;
  final BuildContext outerContext;
  DrabbleSpeedDial(
      {this.url, this.switchLabel = false, required this.outerContext});

  @override
  State<DrabbleSpeedDial> createState() => _DrabbleSpeedDialState();
}

class _DrabbleSpeedDialState extends State<DrabbleSpeedDial> {
  final String ruleBookUrl =
      "https://drive.google.com/file/d/1WnTNgklSC-NFcSmalH-S-u82t5u24hyK/view";
  final String scheduleUrl =
      "https://docs.google.com/spreadsheets/d/1BYnMMtDH9BGHm72VSSc6qXyXbVgrbpKwEtQcGZBdGFk/edit?usp=sharing";
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // animatedIcon: AnimateIcons(
      //   startIcon: Icons.add,
      //   endIcon: Icons.close,
      //   size: 60.0,
      //   onStartIconPress: () {
      //     print("Clicked on Add Icon");
      //   },
      //   onEndIconPress: () {
      //     print("Clicked on Close Icon");
      //   },
      //   duration: Duration(milliseconds: 500),
      //   color: Theme.of(context).primaryColor,
      //   clockwise: false,
      // ),
      icon: Icons.add,
      activeIcon: Icons.close,
      foregroundColor: Colors.white,
      animatedIconTheme: IconThemeData(size: 24.0),
      childrenButtonSize: Size(60, 60),
      switchLabelPosition: widget.switchLabel,
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.transparent,
      overlayOpacity: 0.5,
      closeManually: false,
      backgroundColor: darkTheme.highlightColor,
      spacing: 12.0,
      spaceBetweenChildren: 12.0,
      buttonSize: const Size(60, 60),
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.schedule,
            color: Colors.white,
            size: 24,
          ),
          backgroundColor: darkTheme.highlightColor,
          label: 'Preset',
          //labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PresetsPage(),
              ),
            )
          },
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.edit,
            size: 24,
            color: Colors.white,
          ),
          backgroundColor: darkTheme.highlightColor,
          //labelStyle: TextStyle(fontSize: 18.0),
          label: "Custom",
          onTap: () => {
            Navigator.push(
              widget.outerContext,
              MaterialPageRoute(
                builder: (context) => const HuntEditPage(),
              ),
            )
          },
        ),
      ],
    );
  }
}
