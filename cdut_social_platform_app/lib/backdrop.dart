


import 'package:flutter/material.dart';

class BackDrop extends StatefulWidget{
  const BackDrop({
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
    @required this.controller
  }): assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null),
        assert(controller != null);
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final AnimationController controller;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
class _BackDropState extends State<BackDrop> with SingleTickerProviderStateMixin{
  final GlobalKey _backdropKey=GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Animation<RelativeRect> _layerAnimation;

  @override
  void initState(){
    super.initState();
    _controller=AnimationController(duration: const Duration(microseconds: 300),value: 1,vsync: this);
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 10,
        title: CdutSpBackdropTitle(

        ),
      ),
    );
  }
}
class CdutSpBackdropTitle extends AnimatedWidget{
  const CdutSpBackdropTitle({
    Key key,
    Listenable listenable,
  }):super(key: key,listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation=listenable as Animation<double>;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: CurvedAnimation(
            parent: ReverseAnimation(animation),
            curve: const Interval(0.5, 1),
          ).value,
          child: const Text("个人中心"),
        ),
        Opacity(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1),
          ).value,
          child: Text('成理表白墙'),
        )
      ],
    );
  }

}
