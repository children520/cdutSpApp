import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/cdutSpCardDataModel.dart';
import 'package:flutter/material.dart';
class DetailsPage extends StatefulWidget {
  DetailsPage({Key key,this.detailData}):super(key: key);
  final CdutSpCardData detailData;
  @override
  _DetailPageState createState() {
    return _DetailPageState();
  }
}
class _DetailPageState extends State<DetailsPage>{
  final List<ChatMessage> _messages=<ChatMessage>[];
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final TextEditingController sendMessageController=new TextEditingController();
  bool _isComposing=false;
  double _getAppBarHeight(BuildContext context) =>MediaQuery.of(context).size.height*0.3;
  IconData iconData;
  Color color;
  @override
  Widget build(BuildContext context) {
    final double appBarHeight=_getAppBarHeight(context);
    final Size screenSize=MediaQuery.of(context).size;
    final bool fullWidth=screenSize.width <500;
    final bool isLike=false;
    switch(widget.detailData.label){
      case '表白':
        iconData=Icons.favorite;
        color=cdutSpRed;
        break;
      case '吐槽':
        iconData=Icons.comment;
        color=cdutSpOrange900;
        break;
      case '寻物':
        iconData=Icons.search;
        color=cdutSpBlue100;
    }
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: appBarHeight-28,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('成理表白墙',style: GoogleFonts.zCOOLXiaoWei(fontSize: 24),),
              background: Image.asset(widget.detailData.imageAsset,fit: fullWidth?BoxFit.fitWidth:BoxFit.cover,),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(iconData,color: color,size: 30,),
                            Text(widget.detailData.label,style: GoogleFonts.zCOOLXiaoWei(
                              fontSize: 34
                            ),),
                            Expanded(child: SizedBox(),),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person_outline,size: 25,),
                                SizedBox(width: 10,),
                                Text(widget.detailData.college+'-'+widget.detailData.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 3,
                        child: Container(
                          height: 300,
                          width:MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Text(
                            widget.detailData.content,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: cdutSpGrey,
                              letterSpacing: 2
                            ),
                            softWrap: true,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                            '留言:',
                          style: GoogleFonts.zCOOLXiaoWei(
                            fontSize: 30
                          ),
                        ),
                      )
                    ],
                  ),
                  /*
                  Positioned(
                    right: 16,
                    child: FloatingActionButton(
                      backgroundColor: cdutSpOrange900,
                      child: Icon(Icons.thumb_up),
                      onPressed:(){},
                    ),
                  ),

                   */

                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                    return _messages[index];
                  },
                childCount: _messages.length
              ),
            ),
          )


        ],
      ),
      bottomNavigationBar: _SendMessageComposer(),
      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.thumb_up),
      ),

       */
    );
  }
  Widget _SendMessageComposer(){
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: sendMessageController,
                onSubmitted: _handleSubmitted,
                onChanged: (String text){
                  setState(() {
                    _isComposing=text.length>0;
                  });
                },
                decoration: InputDecoration.collapsed(hintText: '发送留言'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(Icons.send,color: _isComposing? cdutSpBlue100:cdutSpGrey,),
              onPressed: (){
                _isComposing
                ?_handleSubmitted(sendMessageController.text,):null;
              },
            ),
          )
        ],
      ),
    );
  }
  void _handleSubmitted(String text){
    sendMessageController.clear();
    setState(() {
      _isComposing=false;
    });
    ChatMessage message=new ChatMessage(
      message: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }
}
class ChatMessage extends StatelessWidget{
  ChatMessage({this.message});
  final String message;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:  Icon(Icons.account_box,color: cdutSpBlue100,size: 40,),
        title: Text(
          'xiaojun',style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
            message
        ),
        
      ),
    );
  }

}

