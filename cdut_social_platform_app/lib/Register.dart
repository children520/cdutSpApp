import 'dart:convert';

import 'package:cdut_social_platform_app/CdutSpVar.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_picker/flutter_picker.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }

}
class _RegisterPageState extends State<RegisterPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Builder(
          builder:(context)=> SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.assignment_ind,
                      size:30,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '新用户注册',
                      style: GoogleFonts.zCOOLXiaoWei(
                        fontSize: 24
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/logo.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: '用户名',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          counterText: ''
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Text('Boy',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Checkbox(
                                            value: true,
                                            onChanged: (bool value){},
                                          ),
                                          Text('Girl',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Checkbox(
                                            value: false,
                                            onChanged: (bool value){},
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '信息与科学技术学院',
                                style: TextStyle(
                                  color: cdutSpBlue100
                                ),
                              ),
                              Flexible(
                                child: RaisedButton(
                                  child: Text(
                                    '选择学院',
                                    style: TextStyle(
                                      color: cdutSpWhite
                                    ),
                                  ),
                                  onPressed: (){
                                     showPickerArray(context);

                                  },
                                  color: cdutSpBlue100,
                                  //padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '设置你的密码:',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: Icon(
                                  Icons.lock
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              )
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: '验证你的密码:',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Icon(
                                      Icons.lock_outline
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                          ),
                        ),
                        //showPickerArray(context),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: RaisedButton(
                          color: cdutSpBlue100,
                          padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            child: Text(
                              '注册',
                              style: TextStyle(
                                color: cdutSpWhite,
                                fontSize: 18,
                                letterSpacing: 20
                              ),
                            ),
                          ),
                          onPressed: (){
                            final RegistSnackBar=SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '注册成功',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 5
                                  ),
                                ),
                              ),
                              action: SnackBarAction(
                                label: '确 认',
                                textColor: cdutSpBlue100,
                                onPressed: (){},
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              backgroundColor: cdutSpOrange900,
                              behavior: SnackBarBehavior.floating,
                            );
                            Scaffold.of(context).showSnackBar(RegistSnackBar);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ),
        )
      );


  }

}

showPickerArray(BuildContext context) {
  Picker(
      adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(CdutSpVar.CdutSpAcademyList), isArray: true),
      hideHeader: false,
      title: new Text("请选择你的学院",
        style: TextStyle(
            color: cdutSpBlue100,
            fontSize: 16
        ),
      ),
      cancelText: '取消',
      cancelTextStyle: TextStyle(
          color: cdutSpBlue100,
          fontSize: 16
      ),
      confirmText: '确认',
      confirmTextStyle: TextStyle(
          color: cdutSpBlue100,
          fontSize: 16
      ),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
      }
  ).showModal(context);
}