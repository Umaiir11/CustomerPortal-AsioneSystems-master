import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/MVVM/View/VwSignUp.dart';
import 'package:login/MVVM/ViewModel/VmLogin.dart';

import 'VwForgetPassword.dart';

class VwLogin extends StatefulWidget {
  @override
  State<VwLogin> createState() => _VwLoginState();
}

class _VwLoginState extends State<VwLogin> {
  @override
  final VmLogin l_VmLogin = Get.put(VmLogin());

  void initState() {
    // TODO: implement initState
    l_VmLogin.FncWebToken();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController passswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EmailController.text = l_VmLogin.Pr_txtemail_Text;
    passswordController.text = l_VmLogin.Pr_txtpassword_Text;
    Widget togglepassword() {
      return Obx(() {
        return IconButton(
          onPressed: () {
            l_VmLogin.Pr_boolSecurePassword_wid.value = !l_VmLogin.Pr_boolSecurePassword_wid.value;
          },
          icon: l_VmLogin.Pr_boolSecurePassword_wid.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          color: l_VmLogin.Pr_boolSecurePassword_wid.value
              ? Colors.cyan
              : Colors.grey, // set the color based on the toggle state
        );
      });
    }

    Widget _WidgetportraitMode(double Pr_height, Pr_width) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            height: Pr_height,
            width: Pr_width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.1, 0.5, 0.7, 0.9],
              ),
            ),
            //color: Colors.black,
            padding: const EdgeInsets.all(16.0),
            // we use child container property and used most important property column that accepts multiple widgets

            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                        top: Pr_height * 0.22,
                      ),
                      child: Center(
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.w600,
                                    letterSpacing: .5)),
                          ))),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.090),
                    child: Center(
                      child: SizedBox(
                        width: Pr_width * .890,
                        child: Obx(() {
                          return TextFormField(
                              controller: EmailController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[50],
                                labelText: ' Email',
                                hintText: 'Email',
                                hintStyle: const TextStyle(color: Colors.black38),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: l_VmLogin.Pr_autoValidate.value &&
                                        l_VmLogin.Pr_validateEmail(EmailController.text) != null
                                        ? Colors.red
                                        : Colors.white38,
                                  ),
                                ),
                              ),
                              validator: l_VmLogin.Pr_validateEmail,
                              onChanged: (value) {
                                l_VmLogin.Pr_txtemail_Text = value;
                              });
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.03),
                    child: Center(
                      child: SizedBox(
                          width: Pr_width * .890,
                          child: Obx(() {
                            return TextFormField(
                                obscureText: !l_VmLogin.Pr_boolSecurePassword_wid.value,
                                controller: passswordController,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[50],
                                  labelText: ' Password',
                                  hintText: 'Enter Password',
                                  hintStyle: const TextStyle(color: Colors.black38),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: l_VmLogin.Pr_autoValidate.value &&
                                          l_VmLogin.Pr_validatepasword(passswordController.text) != null
                                          ? Colors.red
                                          : Colors.white38,
                                    ),
                                  ),
                                  suffixIcon: togglepassword(),
                                ),
                                validator: l_VmLogin.Pr_validatepasword,
                                onChanged: (value) {
                                  l_VmLogin.Pr_txtpassword_Text = value;
                                });
                          })),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Pr_height * 0.02,
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() {
                                return Checkbox(
                                    value: l_VmLogin.Pr_CheckBox.value,
                                    onChanged: (value) {
                                      l_VmLogin.Pr_CheckBox.value = !l_VmLogin.Pr_CheckBox.value;
                                    });
                              }),
                              Text(
                                "Remember Me",
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        //fontWeight: FontWeight.w600,
                                        letterSpacing: .5)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VwForgetPasswrod());
                                },
                                child: Text(
                                  "Forget Password",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26,
                                          //fontWeight: FontWeight.w600,
                                          letterSpacing: .5)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01),
                    child: Center(
                      child: SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // <-- Radius
                                ),
                                backgroundColor: Colors.cyan),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Show a snackbar message asking the user to fill these fields
                              } else {
                                l_VmLogin.Pr_autoValidate.value = true;
                              }

                              //await l_VmSignUp.Fnc_ValidateLogin();
                              // Get.to(() => VwCompany());
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w600,
                                      letterSpacing: .5)),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.03, right: Pr_width * 0.1),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        //fontWeight: FontWeight.w600,
                                        letterSpacing: .5)),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VwSignUp());
                                },
                                child: Text(
                                  "Sign up",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black26,
                                          //fontWeight: FontWeight.w600,
                                          letterSpacing: .5)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        //when tap anywhere on screen keyboard dismiss
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              //Get device's screen height and width.
              double height = constraints.maxHeight;
              double width = constraints.maxWidth;

              if (width >= 300 && width < 500) {
                return _WidgetportraitMode(height, width);
              } else {
                return _WidgetportraitMode(height, width);
              }
            },
          );
        },
      ),
    );
  }
}
