

import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/cdutSpPageModel.dart';
import 'package:date_format/date_format.dart';
class PostPage extends StatefulWidget{
  PostPage({this.page,Key key}): super(key:key);
  final CdutSpPage page;
  @override
 _PostPageState createState() {
    return _PostPageState();
  }
}
class _PostPageState extends State<PostPage>{

  @override
  Widget build(BuildContext context) {
    DateTime now=DateTime.now();
    String formatDateStr=formatDate(now, [mm, '\\', d,'\\',hh, ':', nn, ':', ' ', am]);
    //final CdutSpPage model =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160,
            title: Text(
              '发表动态',
              style: GoogleFonts.zCOOLXiaoWei(fontSize: 24),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/logo.png',fit: BoxFit.cover,),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(widget.page.iconData,color: widget.page.color,size: 30,),
                      Text(widget.page.label,style: GoogleFonts.zCOOLXiaoWei(
                          fontSize: 34
                      ),),
                      Expanded(child: SizedBox(),),
                      Row(
                        children: <Widget>[
                          Icon(Icons.timer,color: cdutSpGrey,),
                          Text(
                              '当前时间:',
                            style: TextStyle(color: cdutSpGrey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(formatDateStr,style: TextStyle(fontWeight: FontWeight.bold,color: cdutSpGrey),),
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '请输入你想要'+widget.page.label+'的内容,不得超过140字',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 120),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.label)
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: cdutSpBlue100,
                      textColor: cdutSpWhite,
                      padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                      elevation: 8,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '发表',
                          style: TextStyle(
                            fontSize: 14
                          ),
                        ),
                      ),
                      onPressed: (){},
                    ),
                  )



                ],
              ),
            )
          )
        ],
      ),
    );
  }

}