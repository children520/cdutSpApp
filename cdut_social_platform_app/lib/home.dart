
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animations/animations.dart' as animation;

import 'package:cdut_social_platform_app/model/CardMessage.dart';
import 'package:cdut_social_platform_app/post.dart';
import 'package:cdut_social_platform_app/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';
import 'model/cdutSpPageModel.dart';
import 'detail.dart';
import 'package:http/http.dart' as http;
import 'backdrop.dart';
import'package:image/image.dart' as image;
import 'dart:math' as math;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';


/*final Map<CdutSpPage,List<CdutSpCardData>> _allPages=<CdutSpPage,List<CdutSpCardData>>{
  CdutSpPage(label: '表白',iconData: Icons.favorite,color: cdutSpRed):<CdutSpCardData>[
    *//*const CdutSpCardData(
      label: '表白',
      userName: 'xiaoju',
      college: '信科院',
      message: '发哈回复哈哈发动i发方法都i发货发哈回复哈哈发哦配合大佛哈佛好好奋斗发哈合法化的考虑哈夫里哈反恐局发发汗佛啊的肌肤俩号的饭卡很多能否看到看风景 放假啊就放假啊打飞机啊解放军建瓯老师发来的花肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景肤俩号的饭卡很多能否看到看风景',
      imageAsset: 'assets/logo.png',
      //imageAssetPackage: _kGalleryAssetsPackage,
      likeNum: 1,
      date: '2/28/5:38',
    ),
    const CdutSpCardData(
        userName: 'xiaoju',
          label: '表白',
        college: '信科院',
        message: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        likeNum: 1,
        date: '2/28/5:38',
    ),
    const CdutSpCardData(
        userName: 'xiaoju',
        college: '信科院',
        message: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        label: '表白',

        //imageAssetPackage: _kGalleryAssetsPackage,
        likeNum: 1,
         date: '2/28/5:38',
    ),
    const CdutSpCardData(
        userName: 'xiaoju',
        label: '表白',
        college: '信科院',
        message: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',

        //imageAssetPackage: _kGalleryAssetsPackage,
        likeNum: 1,
        date: '2/28/5:38',
    )*//*
  ],
  CdutSpPage(label: '寻物',iconData: Icons.search,color: cdutSpBlue100):<CdutSpCardData>[
    *//*const CdutSpCardData(
        userName: 'xiaoju',
        label: '寻物',
        college: '信科院',
        message: '丢失放假啊回复哈烦的返还话费',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        likeNum: 1,
      date: '2/28/5:38',
    )*//*
  ],
  CdutSpPage(label: '吐槽',iconData: Icons.comment,color: cdutSpOrange900):<CdutSpCardData>[
     *//*CdutSpCardData(
        userName: 'xiaoju',
        label: '吐槽',
        college: '信科院',
        date: '2/28/5:38',
        message: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        likeNum: 1
    )*//*
  ],

};*/

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  static List<CardMessage> favoriteCardMessageList=List();
  static List<CardMessage> searchCardMessageList=List();
  static List<CardMessage> commentCardMessageList=List();
  List<int> idList=List();
  CardMessage cardMessage;
  animation.ContainerTransitionType _transitionType = animation.ContainerTransitionType.fade;
  final GlobalKey _backdropKey=GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Animation<RelativeRect> _layerAnimation;
  CdutSpPage cdutSpPage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String label;
  String ownUserName;
  bool selectedNew=true;
  bool menuSelect=true;
  final Map<CdutSpPage,List<CardMessage>> _allPages=<CdutSpPage,List<CardMessage>>{
    CdutSpPage(label: '表白',iconData: Icons.favorite,color: cdutSpRed):favoriteCardMessageList,
    CdutSpPage(label: '寻物',iconData: Icons.search,color: cdutSpBlue100):searchCardMessageList,
    CdutSpPage(label: '吐槽',iconData: Icons.comment,color: cdutSpOrange900):commentCardMessageList,
  };

  @override
  void initState(){
    super.initState();
    getAllCardMessage();

    Global.init().then((map){
      ownUserName=Global.localUser.userName;
    });
    //removeUserState();
    _controller=AnimationController(duration: const Duration(microseconds: 300),value: 1,vsync: this);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  void initListNewSort(){
    favoriteCardMessageList.sort((left,right)=>right.date.compareTo(left.date));
    searchCardMessageList.sort((left,right)=>right.date.compareTo(left.date));
    commentCardMessageList.sort((left,right)=>right.date.compareTo(left.date));
  }
  void showInSnackBar(String value,bool isNeedCircle){
    _scaffoldKey.currentState..removeCurrentSnackBar()..showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              value
          ),
          SizedBox(
            height: 25,
            width: 25,
            child: isNeedCircle ? CircularProgressIndicator(
              backgroundColor: cdutSpBlue100,
              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
            ):null,
          )
        ],
      ),duration: Duration(seconds: 2),
    ));
  }

  Future<void> _handleRefresh(){
    final Completer<void> completer=Completer<void>();
    showInSnackBar("正在刷新",true);
    completer.complete();
    return completer.future.then((_){
      getAllCardMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        key: _scaffoldKey,
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
        bottomNavigationBar: CdutSpBottomAppBar(color:cdutSpWhite,shape: CircularNotchedRectangle(),callback: menuSelect?getAllCardMessage:getOwnList,)
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
      expandedHeight: 220,
      pinned: true,
      backgroundColor: cdutSpBlue100,
      automaticallyImplyLeading: false,
      forceElevated: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: EdgeInsets.fromLTRB(0,80, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Material(
                  color: selectedNew ? cdutSpWhite38 :cdutSpBlue100,
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Icon(Icons.access_time,color: cdutSpWhite,),
                            SizedBox(width: 20,),
                            Text("最新",style: TextStyle(color: cdutSpWhite),),
                          ],
                        ),
                      ),
                    onTap: !selectedNew ?(){
                      setState(() {
                        if(selectedNew){
                          selectedNew=false;
                        }else{
                          selectedNew=true;
                        }
                      });
                      listNewSort();
                    } :null,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
                SizedBox(height: 5,),
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20,),
                          Icon(Icons.thumb_up,color: cdutSpWhite,),
                          SizedBox(width: 20,),
                          Text("最热",style: TextStyle(color: cdutSpWhite),),
                        ],
                      ),
                    ),
                    onTap: selectedNew ?(){
                        setState(() {
                          if(selectedNew){
                            selectedNew=false;
                          }else{
                            selectedNew=true;
                          }
                        });
                      listHotSort();
                    } :null,
                  ),
                  color: selectedNew ?cdutSpBlue100 :cdutSpWhite38,
                ),
              ],
            ),
          ),
        ),
      ),
      title: CdutSpBackdropTitle(
          listenable:_controller.view
      ),
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.home_menu,
          progress: _controller.view,
        ),
        onPressed: () {
          _CdutSpToggleBackDropVisibility();
          if (menuSelect) {
            menuSelect = false;
            getOwnList();
          } else {
            menuSelect = true;
            getAllCardMessage();
          }
        }
      ),

//      actions: <Widget>[
//        PopupMenuButton(
//          icon: Icon(Icons.expand_more,color: cdutSpWhite,),
//          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//            const PopupMenuItem<String>(
//              child: ListTile(
//                leading: Icon(Icons.access_time),
//                title: Text('最新'),
//              ),
//              value: "new",
//            ),
//            const PopupMenuItem<String>(
//              child: ListTile(
//                leading: Icon(Icons.thumb_up),
//                title: Text('最热'),
//              ),
//              value: "hot",
//            ),
//          ],
//          onSelected: (String action){
//            switch(action){
//              case "new":
//                print("new");
//                listNewSort();
//                break;
//              case "hot":
//                print("hot");
//                listHotSort();
//                break;
//            }
//          },
//        )
//      ],
      bottom: PreferredSize(                       // Add this code
        preferredSize: Size.fromHeight(70.0),      // Add this code
        child: TabBar(
          tabs: _allPages.keys.map<Widget>(
                  (CdutSpPage page) =>
                  Tab(text: page.label, icon: Icon(page.iconData),)
          ).toList(),
        ),                           // Add this code
      ),

    );
  }
  void removeListNotOwn(List list){
    setState(() {
      var toRemove=[];
      for(CardMessage cardMessage in list){
        if(cardMessage.userName!=ownUserName){
          toRemove.add(cardMessage);
        }
      }
      list.removeWhere((e)=>toRemove.contains(e));
    });

  }
  void getOwnList(){
      getAllCardMessage().whenComplete((){
        removeListNotOwn(favoriteCardMessageList);
        removeListNotOwn(searchCardMessageList);
        removeListNotOwn(commentCardMessageList);
      });
  }
  void listNewSort(){
    switch(label){
      case "表白":
        setStateDateSortList(favoriteCardMessageList);
        break;
      case "寻物":
        setStateDateSortList(searchCardMessageList);
        break;
      case "吐槽":
        setStateDateSortList(commentCardMessageList);
        break;
    }
  }
  void setStateDateSortList(List list){
    setState(() {
      list.sort((left,right)=>right.date.compareTo(left.date));
    });
  }
  void setStateLikeNumSortList(List list){
    setState(() {
      list.sort((left,right)=>right.likeNum.compareTo(left.likeNum));
    });
  }
  void listHotSort(){
    switch(label){
      case "表白":
        setStateLikeNumSortList(favoriteCardMessageList);
        break;
      case "寻物":
        setStateLikeNumSortList(searchCardMessageList);
        break;
      case "吐槽":
        setStateLikeNumSortList(commentCardMessageList);
        break;
    }
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
                            final CardMessage data=_allPages[page][index];
                            label=page.label;
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _OpenContainerWrapper(
                                transitionType: _transitionType,
                                data: data,
                                closedBuilder: (BuildContext _,VoidCallback openContainer){
                                  return _CardDataItem(page: page,
                                    data: data,openContainer: openContainer,
                                    onDoubleTapDown: (){
                                       _toggleLiked(data);
                                       updateLikeNumCount(data);
                                    },
                                    onLongPress: !menuSelect ?(){
                                      showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.warning,color: cdutSpOrange900,size: 25,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                                    child: Text("提示",style: TextStyle(color: cdutSpOrange900,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Text("是否删除"+data.userName+"于"+data.date+"发布的消息？"),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: const Text('取消'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              RaisedButton(
                                                child: const Text('确定'),
                                                onPressed: () {
                                                  deleteHttpCardMessage(data);
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      ).then<void>((value){

                                      });

                                    }:null,
                                  );
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
  void deleteListCardMessage(CardMessage cardMessage){
    switch(label){
      case '表白':
        setState(() {
          favoriteCardMessageList.removeWhere((val)=>val.id==cardMessage.id);
        });
    }
  }
  void  _toggleLiked(CardMessage cardMessage) {
    setState(() {
      if(cardMessage.isLiked){
        cardMessage.likeNum--;
        cardMessage.isLiked=false;

      }else{
        cardMessage.likeNum++;
        cardMessage.isLiked=true;
      }
    });

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
     final List<Widget> backdropItems=_allPages.keys.map<Widget>((CdutSpPage page) {
       final bool selected= cdutSpPage==_allPages[0];
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
                         final CardMessage data=_allPages[page][index];
                         label=page.label;
                         return Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: _OpenContainerWrapper(
                             transitionType: _transitionType,
                             data: data,
                             closedBuilder: (BuildContext _,VoidCallback openContainer){
                               return _CardDataItem(page: page,
                                 data: data,openContainer: openContainer,onDoubleTapDown: (){
                                   _toggleLiked(data);
                                   updateLikeNumCount(data);
                                 },
                               );
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
     }).toList();

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
                    child: Text("最新"),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("最热"),
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
              title: Text("最新"),

            ),
          )
        ],
      ),
    );
  }
  Future<http.Response> getAllCardMessage() async{
    final http.Response response=await http.Client().get(
        'http://10.0.2.2:8080/card/all'
    );
    initAllCardMessage(response.body);
    return response;
  }
  void clearAllLists(){
    favoriteCardMessageList.clear();
    searchCardMessageList.clear();
    commentCardMessageList.clear();
  }
  void initAllCardMessage(String response){
    CardMessage cardMessage;
    idList.clear();
    clearAllLists();
    for(var val in json.decode(response)){
      cardMessage=CardMessage.fromjson(val);
      cardMessage.isLiked=false;
      if(!idList.contains(cardMessage.id)){
        idList.add(cardMessage.id);
        switch(val['label']){
          case '表白':
            setState(() {
              favoriteCardMessageList.add(cardMessage);
            });
            break;
          case '寻物':
            setState(() {
              searchCardMessageList.add(cardMessage);
            });

            break;
          case '吐槽':
            setState(() {
              commentCardMessageList.add(cardMessage);
            });
            break;
        }
      }
      initListNewSort();
    }
  }
  Future<http.Response> deleteHttpCardMessage(CardMessage cardMessage) async {
    final http.Response response=await http.Client().delete(
      'http://10.0.2.2:8080/card/delete/'+cardMessage.id.toString(),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    showInSnackBar("正在删除......",true);
    Navigator.pop(context);
    Future.delayed(Duration(seconds: 1),(){
      deleteListCardMessage(cardMessage);
      showInSnackBar(response.body,false);
    });

  }
  Future<http.Response> updateLikeNumCount(CardMessage cardMessage) async{
    final http.Response response=await http.Client().post(
      'http://10.0.2.2:8080/card/update/'+cardMessage.id.toString(),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        'likeNum':cardMessage.likeNum
      }),
    );
    print(response.body);
    return response;
  }
}
void removeUserState() async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.remove("userName");
}

class CdutSpBottomAppBar extends StatelessWidget {
  const CdutSpBottomAppBar({
    this.color,
    this.shape,
    this.callback
  });

  final Color color;
  final NotchedShape shape;
  final VoidCallback callback;

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
//        IconButton(
//          icon: const Icon(Icons.search, semanticLabel: 'show search action',color: cdutSpGrey),
//          onPressed: () {
//            Scaffold.of(context).showSnackBar(
//              const SnackBar(content: Text('寻找'),duration: Duration(seconds: 2)),
//            );
//          },
//        ),
//        IconButton(
//          icon: Icon(
//              Theme.of(context).platform == TargetPlatform.iOS
//                  ? Icons.more_horiz
//                  : Icons.more_vert,
//              semanticLabel: 'Show menu actions', color: cdutSpGrey
//          ),
//          onPressed: () {
//
//            Scaffold.of(context).showSnackBar(
//              const SnackBar(content: Text('菜单栏'),duration: Duration(seconds: 2)),
//            );
//          },
//        ),
        IconButton(
          icon: const Icon(Icons.refresh,color: cdutSpGrey),
          onPressed: callback
        ),
      ]),
    );
  }
}
class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
    this.data
  });

  final animation.OpenContainerBuilder closedBuilder;
  final animation.ContainerTransitionType transitionType;
  final CardMessage data;

  @override
  Widget build(BuildContext context) {
    return animation.OpenContainer(
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
  const _CardDataItem({Key key,this.page,this.data,this.openContainer,this.onDoubleTapDown,this.isLiked,this.onLongPress}):super (key :key);
  final CdutSpPage page;
  final CardMessage data;
  final VoidCallback openContainer;
  final GestureTapCallback onDoubleTapDown;
  final bool isLiked;
  final GestureLongPressCallback onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      onDoubleTap: onDoubleTapDown,
      onLongPress: onLongPress,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      //borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            child: Image.asset('assets/logo.png',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(data.collage+':',
                        style: TextStyle(
                            fontSize: 12,
                            color: cdutSpBlue100,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Text(
                          data.userName,
                          style: TextStyle(
                              fontSize: 12,
                              color: cdutSpBlue100,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(data.message,
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(page.iconData,color: page.color,size: 16,),
                      Text(
                        data.date.substring(5,17),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      LikeWidget(cardMessage: data,isLiked: isLiked,)
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
String getRandomImageStr(){
  var random=new Random();
  String imageStr='assets/images/cdutsp_image_'+random.nextInt(25).toString()+'.jpg';
  //print(imageStr);
  return imageStr;
}
void preCacheImageAllImages(BuildContext context){
  for(int i=0;i<=25;i++){
    String imageStr='assets/images/cdutsp_image_'+i.toString()+'.jpg';
    precacheImage(AssetImage(imageStr), context);
  }

}

class LikeWidget extends StatefulWidget{
  final CardMessage cardMessage;
  final bool isLiked;
  LikeWidget({this.cardMessage,this.isLiked});
  @override
  _LikeWidgetState createState() {
    return _LikeWidgetState();
  }
}

class _LikeWidgetState extends State<LikeWidget>{

//考虑死锁的问题，类似于java中的votile
  @override
  Widget build(BuildContext context) {
    //print(widget.cardMessage.id);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.zero,
          child: Icon(Icons.thumb_up,
            size: 18,
            color: widget.cardMessage.isLiked ? cdutSpOrange900:cdutSpGrey,),
        ),
        SizedBox(
          width: 18,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              widget.cardMessage.likeNum.toString(),
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


}

class CdutSpFloatingActionButton extends StatefulWidget{
  @override
  CdutSpFloatingActionButtonState createState() {
    return CdutSpFloatingActionButtonState();
  }
}
class CdutSpFloatingActionButtonState extends State<CdutSpFloatingActionButton>{
  @override
  Widget build(BuildContext context) {
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