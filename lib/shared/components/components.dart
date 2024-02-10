import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/Shop_Login_Screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

Widget DefaultButton({
  bool isUpperCase = false,
  double width = double.infinity,
  Color color = Colors.tealAccent,
  double radius = 0.0,
  @required Function function,
  @required String text,
  double elevation = 20,
  Color textColor = Colors.white,
}) => Container(

  width: width,
  height: 40,
  decoration: BoxDecoration(
    borderRadius: BorderRadiusDirectional.circular(radius),
    color: color,
  ),
  child: MaterialButton(
    elevation: elevation,
    height: 40,
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: textColor,
      ),
    ),
  ),
);

Widget DefaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String LabelText,
  Function SubmitFunction,
  Function ChangeFunction,
  IconData prefixicon,
  @required Function validate,
  IconData SufixIcon,
  bool isObscure = false,
  Function isSuffixpressed,
  Function onTap,
  bool enabled,
  Color color
}) => TextFormField(
  cursorColor: Colors.purple[400],
  controller: controller,
  onFieldSubmitted: SubmitFunction,
  onChanged: ChangeFunction ,
  enabled: enabled,
  keyboardType: type ,
  obscureText: isObscure,
  onTap: onTap,
  decoration: InputDecoration(
    labelStyle: TextStyle(
      fontSize: 18
    ),
    labelText: LabelText,
    prefixIcon: Icon(
      prefixicon,
      color: color,
    ),
    suffixIcon: SufixIcon!= null ? IconButton(icon : Icon(SufixIcon),onPressed: isSuffixpressed, ): null,
    border: OutlineInputBorder(),
  ),
  validator: validate,
);

void DefaultToast({
  @required String message,
  Color Backgroundcolor = Colors.purple,
  @required double fontsize,
})
{
  Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: Backgroundcolor,
  textColor: Colors.white,
  fontSize: fontsize,
);}
