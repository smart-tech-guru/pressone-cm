import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motel/appTheme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController email_text_controller = new TextEditingController();
  GlobalKey<FormState> form_key = new GlobalKey();
  bool success=false;

  Future<dynamic> forgot_password_api_call() async {
    String url =
        'https://staging.joinflyline.com/api/password_reset/'; // here i am checking with my own api
    var response =
        await http.post(url, body: {"email": email_text_controller.text});

    if(response.statusCode==200){
      success=true;

    }
    else{
      setState(() {
        success = false;

      }
      );
    }

    //this is output i got

//         I/flutter (11222): response body is  Instance of 'Response'.body
// I/flutter (11222):
// I/flutter (11222): {"balance":null,"email":null,"response_desc":"User id found"}
    // return json_decode(response.body);

    print("response body is  " + '$response.body');
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: AppTheme.getTheme().backgroundColor,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: appBar(),
              ),
              Expanded(
                child: Form(
                  key: form_key,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 16.0, left: 24, right: 24),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Enter your email to receive a mail to\nreset your password",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.getTheme().disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1)),
                              // border: Border.all(
                              //   color: HexColor("#757575").withOpacity(0.6),
                              // ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Container(
                                height: 48,
                                child: Center(
                                  child: TextFormField(
                                    controller: email_text_controller,
                                    maxLines: 1,
                                    onChanged: (String txt) {},
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    cursorColor:
                                        AppTheme.getTheme().primaryColor,
                                    decoration: new InputDecoration(
                                      errorText: null,
                                      border: InputBorder.none,
                                      hintText: "Your Email",
                                      hintStyle: TextStyle(
                                          color: AppTheme.getTheme()
                                              .disabledColor),
                                    ),
                                    validator: (value) {
                                      if (value == "") {
                                        return "Email must not be null";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 8, top: 16),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (form_key.currentState.validate()) {
                                    await forgot_password_api_call();
                                    if(success==false)
                                     return
                                     Alert(context: context,title:"something went wrong !",style:AlertStyle(
                                       titleStyle: TextStyle(fontSize: 16),
                                     ) ).show();
                                    else
                                     Navigator.pop(context);
                                  }
                                },

                                child: Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "Forgot Password",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
