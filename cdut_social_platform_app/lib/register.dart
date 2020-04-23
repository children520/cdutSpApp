import 'dart:convert';
import 'package:cdut_social_platform_app/CdutSpVar.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget{
  static const routeName = '/register';
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }

}
class _RegisterPageState extends State<RegisterPage>{
  int RadioValue=0;
  bool _autoValidate=false;
  bool _formWasEdited=false;
  Future<User> _futureUser;
  //默认学院和性别
  User _user=User(sex: "Boy",collage: "地球科学学院");

  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey=GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        drawerDragStartBehavior: DragStartBehavior.down,
        body:  SafeArea(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      _BuildTitle(),
                      SizedBox(height: 10,),
                      Column(
                        children: <Widget>[
                          _BuildUserNameTextField(),
                          _BuildPicker(context),
                          SizedBox(height: 10,),
                          _BuildPassWordAndPhoneNumberTextField()
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          _BuildRaiseButton()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ),

      );


  }
  Widget BuildRadio(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
      child: Row(
        children: <Widget>[
          Text('Boy',
            style: Theme.of(context).textTheme.body2,
          ),
          Radio<int>(
              value: 0,
              groupValue: RadioValue,
              onChanged:handleRadioValueChanged,
              
          ),
          SizedBox(width: 20,),
          Text('Girl',
            style: Theme.of(context).textTheme.body2,
          ),
          Radio<int>(
            value: 1,
            groupValue: RadioValue,
            onChanged: handleRadioValueChanged,
          ),
        ],
      ),
    );
  }

  void handleRadioValueChanged(int value){
    setState(() {
      RadioValue=value;
    });
    RadioValue==0?_user.sex="Boy":_user.sex="Girl";
  }

  String _ValidateUserName(String value) {
    _formWasEdited=true;
    if(value.isEmpty){
      return '用户名不能为空';
    }
    final RegExp nameExp=RegExp(r'^[\u4e00-\u9fa5_a-zA-Z0-9]+$');
    if(!nameExp.hasMatch(value)){
      return '用户名格式不正确';
    }
    return null;
  }
  String _ValidatePassword(String value) {
    _formWasEdited=true;
    final FormFieldState<String> passwordField=_passwordFieldKey.currentState;
    final RegExp passwordExp=RegExp(r'^[a-zA-Z0-9]+$');
    if(!passwordExp.hasMatch(passwordField.value)){
      return '密码格式不正确';
    }
    if(passwordField.value.length<=7){
      return '密码长度至少为8个字符';
    }
    if(passwordField.value!=value){
      return '密码不匹配';
    }
    return null;
  }
  String _ValidateEmail(String value){
    _formWasEdited=true;
    final RegExp phoneExp=RegExp('\^[1-9][0-9]{4,}@qq.com\$');
    if(!phoneExp.hasMatch(value)){
      return '邮箱格式不正确';
    }
    return null;
  }
  String _ValidatePhoneNumber(String value){
    _formWasEdited=true;
    final RegExp phoneExp=RegExp('^1[3|4|5|8][0-9]\\d{8}\$');
    if(!phoneExp.hasMatch(value)){
      return '电话号码格式不正确';
    }
    if(value.length!=11){
      return '电话号码长度错误';
    }

    return null;
  }


  void _handleRegisted() {
    final FormState formState=_formKey.currentState;
    if(!formState.validate()){
      _autoValidate=true;
      //showInSnackBar('请更正提交之前的错误！');
    }else{

      formState.save();
      showInSnackBar('正在注册......');
      Future.delayed(Duration(seconds: 2),(){
        setState(() {
          print(_user.userName);
          print(_user.sex);
          print(_user.collage);
          print(_user.password);
          print(_user.email);
          print(_user.phoneNumber);
          _futureUser=createUser(_user);
        });
      });

    }
    //final FormState
  }
  
  

  void showInSnackBar(String value){
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
            child: CircularProgressIndicator(
              backgroundColor: cdutSpBlue100,
              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
            ),
          )
        ],
      ),duration: Duration(seconds: 2),
    ));
  }
  Widget _BuildPicker(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _user.collage,
          style: TextStyle(
              color: cdutSpBlue100
          ),
        ),
        Flexible(
          child: RaisedButton(
            child: Text(
              '选择学院',
            ),
            onPressed: (){
              showPickerArray(context);
            },
            //padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
          ),
        ),
      ],
    );
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
          setState(() {
            _user.collage=picker.getSelectedValues()[0];
          });
          print(picker.getSelectedValues()[0]);
        },
    ).showModal(context);
  }

  Widget _BuildPassWordAndPhoneNumberTextField(){
    return Column(
      children: <Widget>[
        PasswordField(
          fieldKey: _passwordFieldKey,
          labelText: '设置你的密码：',
          hintText: '至少八个字符（英文，数字）',
          validator: _ValidatePassword,
          onFieldSubmitted: (String value) {
            setState(() {
              _user.password = value;
            });
          },
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            enabled: _user.password!=null&&_user.password.isNotEmpty,
            decoration: InputDecoration(
                labelText: '验证你的密码:',
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Icon(
                      Icons.lock_outline
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
            obscureText: true,
            validator: _ValidatePassword,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: '输入你的QQ邮箱:',
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Icon(
                    Icons.email
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
          ),
          validator: _ValidateEmail,
          onFieldSubmitted: (String value) {
            setState(() {
              _user.email = value;
            });
          },
        ),
        SizedBox(height: 10,),
        TextFormField(
          validator: _ValidatePhoneNumber,
          decoration: InputDecoration(
              hintText: '输入你的手机号码:',
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Icon(
                    Icons.phone
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),

          ),
          onFieldSubmitted: (String value){
            setState(() {
              _user.phoneNumber=value;
            });

          },
        ),
      ],
    );
  }
  Widget _BuildTitle(){
    return Row(
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
            style: Theme.of(context).textTheme.headline
        ),
      ],
    );
  }
  Widget _BuildUserNameTextField(){
    return Row(
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
                padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: '用户名',
                    border: UnderlineInputBorder(
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 20,
                    ),
                  ),
                  onSaved: (String value) {_user.userName= value;},
                  validator: _ValidateUserName,
                ),
              ),
              BuildRadio()
            ],
          ),
        ),

      ],
    );
  }
  Widget _BuildRaiseButton(){
    return Expanded(
      child: RaisedButton(
        color: cdutSpBlue100,
        padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
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
        onPressed: _handleRegisted,
      ),
    );
  }
  Future<User> createUser(User user) async{
    Map<String,dynamic> returnResult=new Map();
    returnResult['userName']=user.userName;
    returnResult['password']=user.password;
    final http.Response response= await http.Client().post(
      'http://10.0.2.2:8080/user/registration',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        'userName':user.userName,
        'password':user.password,
        'collage':user.collage,
        'sex':user.sex,
        'email':user.email,
        'phoneNumber':user.phoneNumber
      }),
    );
    print(response.body);
    print(response.statusCode);
    Map<String,dynamic> responseJson=json.decode(response.body);
    if(response.statusCode==200){
      showInSnackBar('用户'+responseJson['userName']+'注册成功，即将跳转到登陆页面');
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pop(context, returnResult);
      });
    }else{
      String message=responseJson['message'];
      showInSnackBar(message);
      //throw Exception('注册失败');
    }
  }
  void _sendToVerificationCode(){

  }
  /*
  Future<http.Response> searchUserIsRepeated(String _userName,String phoneNumber) async{
    String url='http://10.0.2.2:8080/_user/';
    if(_userName.isNotEmpty){
      url=url+'_userName/'+_userName;
    }
    if(phoneNumber.isNotEmpty){
      url=url+'phoneNumber/'+phoneNumber;
    }
    final http.Response response= await http.Client().get(
      url,
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if(response.statusCode==200){

    }else{
      if(_userName.isEmpty){
        showInSnackBar('手机号已注册');
      }
      else{
        showInSnackBar('用户名已注册');
      }
    }
    return response;
  }

   */
}



class PasswordField extends StatefulWidget{
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  const PasswordField({this.fieldKey,this.hintText,this.labelText,this.helperText,
    this.validator,this.onFieldSubmitted,this.onSaved,this.controller
  });

  @override
  _PasswordFieldState createState() {
    return _PasswordFieldState();
  }


}
class _PasswordFieldState extends State<PasswordField>{
  bool _obsucreText=true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obsucreText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.start,
          onTap: (){
            setState(() {
              _obsucreText=!_obsucreText;
            });
          },
          child: Icon(
            _obsucreText ?Icons.visibility:Icons.visibility_off,
            semanticLabel: _obsucreText?'显示密码':'隐藏密码',
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Icon(
              Icons.lock
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}

