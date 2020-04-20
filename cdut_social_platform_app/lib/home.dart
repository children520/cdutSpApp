
import 'dart:ffi';
import 'package:animations/animations.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:cdut_social_platform_app/post.dart';
import 'package:cdut_social_platform_app/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/cdutSpPageModel.dart';
import 'model/cdutSpCardDataModel.dart';
import 'detail.dart';
import 'backdrop.dart';
import 'package:cdut_social_platform_app/global.dart';
import 'dart:math' as math;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';


final Map<CdutSpPage,List<CdutSpCardData>> _allPages=<CdutSpPage,List<CdutSpCardData>>{
  CdutSpPage(label: '表白',iconData: Icons.favorite,color: cdutSpRed):<CdutSpCardData>[
    const CdutSpCardData(
      label: '表白',
      name: 'xiaoju',
      college: '信科院',
      content: '发哈回复哈哈发动i发方法都i发货发哈回复哈哈发哦配合大佛哈佛好好奋斗发哈合法化的考虑哈夫里哈反恐局发发汗佛啊的肌肤俩号的饭卡很多能否看到看风景 放假啊就放假啊打飞机啊解放军建瓯老师发来的花肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景',
      imageAsset: 'assets/logo.png',
      //imageAssetPackage: _kGalleryAssetsPackage,
      like: 1,
      time: '2/28/5:38',
    ),
    const CdutSpCardData(
        name: 'xiaoju',
          label: '表白',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
        time: '2/28/5:38',
    ),
    const CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        label: '表白',

        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
         time: '2/28/5:38',
    ),
    const CdutSpCardData(
        name: 'xiaoju',
        label: '表白',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',

        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
        time: '2/28/5:38',
    )
  ],
  CdutSpPage(label: '寻物',iconData: Icons.search,color: cdutSpBlue100):<CdutSpCardData>[
    const CdutSpCardData(
        name: 'xiaoju',
        label: '寻物',
        college: '信科院',
        content: '丢失放假啊回复哈烦的返还话费',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
      time: '2/28/5:38',
    )
  ],
  CdutSpPage(label: '吐槽',iconData: Icons.comment,color: cdutSpOrange900):<CdutSpCardData>[
    const CdutSpCardData(
        name: 'xiaoju',
        label: '吐槽',
        college: '信科院',
        time: '2/28/5:38',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1
    )
  ],

};
class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final GlobalKey _backdropKey=GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Animation<RelativeRect> _layerAnimation;
  CdutSpPage cdutSpPage;
  String userName;

  @override
  void initState(){
    super.initState();
    
    _controller=AnimationController(duration: const Duration(microseconds: 300),value: 1,vsync: this);
  }
  @override
  void dispose(){
    _controller.dispose();
    print("dispose");
    super.dispose();

  }

  void removeUserState() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("userName");
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context),
                child: buildSliverAppBar()
              )
            ];
          },
          body: buildTabBarView()
        ),
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CdutSpBottomAppBar(color:cdutSpWhite,shape: CircularNotchedRectangle(),),
      ),
    );
  }
  Widget buildFloatingActionButton(){
    return FloatingActionButton(
      child: Icon(Icons.brush),
      elevation: 8,
      backgroundColor: cdutSpOrange900,
      onPressed: (){
        ShowPostPage(context, cdutSpPage);
      },
    );
  }
  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      backgroundColor: cdutSpBlue100,
      automaticallyImplyLeading: false,
      forceElevated: true,
      centerTitle: true,
      title: CdutSpBackdropTitle(
          listenable:_controller.view
      ),
      leading: IconButton(
        icon: AnimatedIcon(



          icon: AnimatedIcons.close_menu,
          progress: _controller.view,
        ),
        onPressed: _CdutSpToggleBackDropVisibility,
      ),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.expand_more,color: cdutSpWhite,),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              child: ListTile(
                leading: Icon(Icons.access_time),
                title: Text('时间'),
              ),
            ),
            const PopupMenuItem<String>(
              child: ListTile(
                leading: Icon(Icons.thumb_up),
                title: Text('热度'),
              ),
            ),
          ],
        )
      ],
      bottom: TabBar(
        tabs: _allPages.keys.map<Widget>(
                (CdutSpPage page) =>
                Tab(text: page.label, icon: Icon(page.iconData),)
        ).toList(),
      ),
    );
  }
  Widget buildTabBarView(){
    return TabBarView(
        children: _allPages.keys.map<Widget>((CdutSpPage page) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (BuildContext context) {
                cdutSpPage=page;
                return CustomScrollView(
                  key: PageStorageKey<CdutSpPage>(page),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView
                          .sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9
                      ),
                      delegate: SliverChildBuilderDelegate(
                              (BuildContext context,int index){
                            final CdutSpCardData data=_allPages[page][index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _OpenContainerWrapper(
                                transitionType: _transitionType,
                                data: data,
                                closedBuilder: (BuildContext _,VoidCallback openContainer){
                                  return _CardDataItem(page: page,
                                    data: data,openContainer: openContainer,);
                                },
                              ),
                            );
                          },
                          childCount: _allPages[page].length
                      ),
                    )
                  ],
                );
              },
            ),
          );

        }).toList()
    );
  }
  void ShowPostPage(BuildContext context,CdutSpPage page){
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context)=>PostPage(
          page:page
      ),
    ));
  }
  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  void _CdutSpToggleBackDropVisibility(){
    _controller.fling(velocity: _CdutBackDropPanelVisible?-2.0:2.0);
  }
  bool get _CdutBackDropPanelVisible{
    final AnimationStatus status=_controller.status;
    return status==AnimationStatus.completed||status==AnimationStatus.forward;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }
  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  Widget _buildCdutSpStack(BuildContext context,BoxConstraints constraints){
     const double panTitleHeight=48;
     final Size panelSize=constraints.biggest;
     final ThemeData theme = Theme.of(context);
     final double panelTop=panelSize.height-panTitleHeight;
     final Animation<RelativeRect> panelAnimation=_controller.drive(
       RelativeRectTween(
          begin: RelativeRect.fromLTRB(
              0.0,
              panelTop-MediaQuery.of(context).padding.bottom,
              0.0,
              panelTop-panelSize.height
          ),
         end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
       )
     );
     //final List<CdutSpPage> backdropItems=_allPages.
    return Container(
      key: _backdropKey,
      child: Stack(
        children: <Widget>[
          ListTileTheme(
            iconColor: theme.primaryIconTheme.color,
            textColor: theme.primaryTextTheme.headline.color.withOpacity(0.6),
            selectedColor: theme.primaryTextTheme.headline.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("热度"),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("时间"),
                  )
                ],
              ),
            ),
          ),
          PositionedTransition(
            rect: panelAnimation,
            child: BackdropPanel(
              onTap: _CdutSpToggleBackDropVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              title: Text("热度"),
            ),
          )
        ],
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
    this.data
  });

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final CdutSpCardData data;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 2,
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return DetailsPage(detailData: data,);
      },
      tappable: true,
      closedBuilder: closedBuilder,
    );
  }
}
class _CardDataItem extends StatelessWidget{
  const _CardDataItem({Key key,this.page,this.data,this.openContainer}):super (key :key);
  final CdutSpPage page;
  final CdutSpCardData data;
  final VoidCallback openContainer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      //borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            child: Image.asset(data.imageAsset,
              //package:data.imageAssetPackage,
              fit: BoxFit.fitWidth,),
            aspectRatio: 24/13,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(data.college+'-',
                        style: TextStyle(
                            fontSize: 12,
                            color: cdutSpBlue100,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 12,
                            color: cdutSpBlue100,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(data.content,
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(page.iconData,color: page.color,size: 16,),
                      Text(
                        data.time,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      LikeWidget()


                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class CdutSpBottomAppBar extends StatelessWidget {
  const CdutSpBottomAppBar({
    this.color,
    this.shape,
  });

  final Color color;
  final NotchedShape shape;

  static final List<FloatingActionButtonLocation> kCenterLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: color,
      shape: shape,
      child: Row(children: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings, semanticLabel: 'Show bottom sheet',color: cdutSpGrey,),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) => _CdutSpDrawer(),
            );
          },
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: const Icon(Icons.search, semanticLabel: 'show search action',color: cdutSpGrey),
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              const SnackBar(content: Text('寻找'),duration: Duration(seconds: 2)),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.more_horiz
                : Icons.more_vert,
            semanticLabel: 'Show menu actions', color: cdutSpGrey
          ),
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              const SnackBar(content: Text('菜单栏'),duration: Duration(seconds: 2)),
            );
          },
        ),
      ]),
    );
  }
}
class LikeWidget extends StatefulWidget{
  @override
  _LikeWidgetState createState() {
    return _LikeWidgetState();
  }

}

class _LikeWidgetState extends State<LikeWidget>{
  bool _isLiked=false;
  //考虑死锁的问题，类似于java中的votile
  int _likeCount=0;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.zero,
          child: GestureDetector(
            onTap: (){
              _toggleLiked();
            },
            child: Icon(Icons.thumb_up,
              size: 18,
              color: _isLiked ? cdutSpOrange900:cdutSpGrey,),
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              '$_likeCount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cdutSpGrey
              ),
            ),
          ),
        )
      ],
    );
  }

  void _toggleLiked() {
    setState(() {
      if(_isLiked){
        _likeCount--;
        _isLiked=false;
      }else{
        _likeCount++;
        _isLiked=true;
      }
    });
  }

}
class CdutSpFloatingActionButton extends StatefulWidget{
  @override
  CdutSpFloatingActionButtonState createState() {
    // TODO: implement createState
    return CdutSpFloatingActionButtonState();
  }
}
class CdutSpFloatingActionButtonState extends State<CdutSpFloatingActionButton>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
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
          child: Text("我的发布",
              style:GoogleFonts.zCOOLXiaoWei(
                fontSize: 25,
                color: cdutSpWhite
              )
            ),
        ),
        Opacity(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1),
          ).value,
          child: Text('成理表白墙',
              style:GoogleFonts.zCOOLXiaoWei(
              fontSize: 25,
                  color: cdutSpWhite
          )
          ),
        )
      ],
    );
  }
}

class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      elevation: 2.0,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                style: theme.textTheme.subtitle,
                child: Tooltip(
                  message: 'Tap to dismiss',
                  child: title,
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _CdutSpDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const <Widget>[
          Card(
              child: ListTile(
                leading: Icon(Icons.book,color: cdutSpBlue100),
                title: Text('程序简介'),
              )
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.people,color: cdutSpBlue100,),
              title: Text('关于我们'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone,color: cdutSpBlue100),
              title: Text('联系我们'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.chat,color: cdutSpBlue100),
              title: Text('反馈建议'),
            ),
          ),
        ],
      ),
    );
  }

}