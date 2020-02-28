
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:google_fonts/google_fonts.dart';
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';
class _CdutSpPage{
  _CdutSpPage({this.label,this.icon});
  final String label;
  final Icon icon;
  @override
  String toString() {
    return '$runtimeType("$label")';
  }
}

class _CdutSpCardData{
  const _CdutSpCardData({
    this.name,
    this.college,
    this.content,
    this.imageAsset,
    this.imageAssetPackage,
    this.like,
    this.time
  });
  final String name;
  final String college;
  final String content;
  final String imageAsset;
  final String imageAssetPackage;
  final String time;
  final num like;


}
final Map<_CdutSpPage,List<_CdutSpCardData>> _allPages=<_CdutSpPage,List<_CdutSpCardData>>{
  _CdutSpPage(label: '表白',icon: Icon(Icons.favorite_border)):<_CdutSpCardData>[
    const _CdutSpCardData(
      name: 'xiaoju',
      college: '信科院',
      content: '发哈回复哈哈发动i发方法都i发货',
      imageAsset: 'assets/logo.png',
      //imageAssetPackage: _kGalleryAssetsPackage,
      like: 1,
      time: '2/28/5:38',
    ),
    const _CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
        time: '2/28/5:38',
    ),
    const _CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',

        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
         time: '2/28/5:38',
    ),
    const _CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',

        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
        time: '2/28/5:38',
    )
  ],
  _CdutSpPage(label: '寻物',icon: Icon(Icons.search)):<_CdutSpCardData>[
    const _CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        content: '丢失放假啊回复哈烦的返还话费',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1,
      time: '2/28/5:38',
    )
  ],
  _CdutSpPage(label: '吐槽',icon: Icon(Icons.comment)):<_CdutSpCardData>[
    const _CdutSpCardData(
        name: 'xiaoju',
        college: '信科院',
        time: '2/28/5:38',
        content: '发哈回复哈哈发动i发方法都i发货',
        imageAsset: 'assets/logo.png',
        //imageAssetPackage: _kGalleryAssetsPackage,
        like: 1
    )
  ],

};
class HomePage extends StatelessWidget {
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
                child: SliverAppBar(
                  backgroundColor: cdutSpBlue100,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  expandedHeight: 160,
                  pinned: true,
                  title: Text(
                    "成理表白墙",
                    style: GoogleFonts.zCOOLXiaoWei(
                        fontSize: 24
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.person,color: cdutSpWhite,),
                    onPressed: (){

                    },
                  ),

                  actions: <Widget>[
                    PopupMenuButton(
                      icon: Icon(Icons.expand_more,color: cdutSpWhite,),
                      //color: cdutSpWhite70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 10,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Preview',
                          child: ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text('时间'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Share',
                          child: ListTile(
                            leading: Icon(Icons.thumb_up),
                            title: Text('热度'),
                          ),
                        ),
                      ],
                    )
                  ],
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _allPages.keys.map<Widget>(
                          (_CdutSpPage page) =>
                          Tab(text: page.label, icon: page.icon,),
                    ).toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
              children: _allPages.keys.map<Widget>((_CdutSpPage page) {
                return SafeArea(
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<_CdutSpPage>(page),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle: NestedScrollView
                                .sliverOverlapAbsorberHandleFor(context),
                          ),
                         SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 0.75
                              ),
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context,int index){
                                    final _CdutSpCardData data=_allPages[page][index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: _CardDataItem(
                                        page: page,
                                        data: data,
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.brush),
          elevation: 10,
          backgroundColor: cdutSpOrange900,
          onPressed: (){},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _CdutSpBottomAppBar(color:cdutSpWhite,shape: CircularNotchedRectangle(),),
      ),
    );
  }
}
class _CardDataItem extends StatelessWidget{
  const _CardDataItem({this.page,this.data});
  final _CdutSpPage page;
  final _CdutSpCardData data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            child: Image.asset(data.imageAsset,
              //package:data.imageAssetPackage,
              fit: BoxFit.fitWidth,),
            aspectRatio: 16/9,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(data.college+'-',
                        style: TextStyle(
                            fontSize: 14,
                            color: cdutSpBlue100,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 14,
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
                            fontSize: 12
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data.time,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Icon(Icons.thumb_up,
                          size: 18,
                          color: cdutSpGrey,),
                      )


                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),


      //child: ,
    );
  }

}
class _CdutSpBottomAppBar extends StatelessWidget {
  const _CdutSpBottomAppBar({
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
          icon: const Icon(Icons.menu, semanticLabel: 'Show bottom sheet'),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              //builder: (BuildContext context) => const _DemoDrawer(),
            );
          },
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: const Icon(Icons.search, semanticLabel: 'show search action',),
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              const SnackBar(content: Text('寻找'),duration: Duration(seconds: 2),),
            );
          },
        ),
        IconButton(
          icon: Icon(
            Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.more_horiz
                : Icons.more_vert,
            semanticLabel: 'Show menu actions',
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
