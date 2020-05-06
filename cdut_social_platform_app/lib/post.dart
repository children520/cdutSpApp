
import 'dart:async';
import 'dart:convert';

import 'package:cdut_social_platform_app/global.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:http/http.dart' as http;
import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/CardMessage.dart';
import 'model/cdutSpPageModel.dart';
import 'package:date_format/date_format.dart';
class PostPage extends StatefulWidget{
  static const routeName = '/post';
  PostPage({this.page,Key key}): super(key:key);
  final CdutSpPage page;

  @override
 _PostPageState createState() {
    return _PostPageState();
  }
}
class _PostPageState extends State<PostPage>{
  static DateTime now;
  String formatDateStr;
  Timer timer;
  int milliSecond;
  CardMessage cardMessage=new CardMessage();
  bool _autoValidate=false;
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  void initState(){
    now=DateTime.now();
    milliSecond=now.millisecondsSinceEpoch;
    formatDateStr=formatDate(now, [yyyy,'年',mm, '月', d,'号 ',hh, ':', nn,':',ss]);
    startTimer();
    Global.init().then((map){
      cardMessage.userName=Global.localUser.userName;
      cardMessage.collage=Global.localUser.collage;
    });
    super.initState();
  }
  @override
  void deactivate() {
    super.deactivate();
  }
  @override
  void didUpdateWidget(PostPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    super.dispose();
    if(timer!=null){
      timer.cancel();
    }
  }

  void startTimer(){
    const oneSecond=const Duration(seconds: 1);
    timer= new Timer.periodic(oneSecond,(timer){
      setState(() {
        milliSecond+=1000;
        formatDateStr=formatDate(DateTime.fromMillisecondsSinceEpoch(milliSecond), [yyyy,'年',mm, '月', d,'号 ',hh, ':', nn,':',ss]);
      });
    }
    );

  }
  @override
  Widget build(BuildContext context) {

    //final CdutSpPage model =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            buildSliverAppBar(),
            buildSliverPadding()
          ],
        ),
      ),
    );
  }
  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      title: Text(
        '发表动态',
        style: GoogleFonts.zCOOLXiaoWei(fontSize: 24,color: cdutSpWhite),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('assets/logo.png',fit: BoxFit.cover,),
      ),
    );
  }
  Widget buildSliverPadding(){
    return SliverPadding(
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
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: '请输入你想要'+widget.page.label+'的内容,不得超过140字',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 120),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.label),
                ),
                validator: _ValidateInputMessage,
                onSaved: (String val){
                  setState(() {
                    cardMessage.message=val;
                  });

                },
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
                  onPressed: (){
                    _handleCommit(context);
                  },
                ),
              )



            ],
          ),
        )
    );
  }

  String _ValidateInputMessage(String value){
    if(value.length>140){
      return "超过字数范围";
    }
    if(value.isEmpty){
      return "输入不能为空";
    }
    if(value.length<20){
      return "至少20个字符";
    }
  }
  void _handleCommit(BuildContext context){
    final FormState formState=_formKey.currentState;
    if(!formState.validate()){
      _autoValidate=true;
    }else{
      formState.save();
      commitMessage(cardMessage,context);
    }
  }
  void initCardDefaultMessage(CardMessage cardMessage){
    cardMessage.label=widget.page.label;
    cardMessage.likeNum=0;
    cardMessage.date=formatDateStr;
  }
  Future<String> commitMessage(CardMessage cardMessage,BuildContext context) async{
    initCardDefaultMessage(cardMessage);
    final http.Response response=await http.Client().post(
      'http://10.0.2.2:8080/card/commit',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        'userName':cardMessage.userName,
        'message':cardMessage.message,
        'label':cardMessage.label,
        'likeNum':cardMessage.likeNum,
        'date':cardMessage.date,
        'collage':cardMessage.collage
      }),
    );
    print(response.body);
    showSnackBar("正在发布......",true,2);
    Future.delayed(Duration(seconds: 2),(){
      showSnackBar(response.body,false,4);
    });

  }
  void listAdd(){
    switch(widget.page.label){
      case "表白":
        setState(() {
          //HomePageState.favoriteCardMessageList.add(cardMessage);
        });

    }
  }
  void showSnackBar(String val,bool isCir,int sec){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
             val
          ),
          isCir?SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              backgroundColor: cdutSpBlue100,
              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
            ) ,
          ):SizedBox(height:25,child: FlatButton(
              child:Text('确认',
                style: TextStyle(
                  color: cdutSpBlue100,
                ),),
              onPressed: (){
                _scaffoldKey.currentState.removeCurrentSnackBar();
              }))
        ],
      ),duration: Duration(seconds: sec),
    ));
  }
}
