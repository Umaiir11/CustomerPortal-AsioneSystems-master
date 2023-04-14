import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/MVVM/View/VwSignUp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../ViewModel/VmSignup.dart';

class VwLogin extends StatefulWidget {
  @override
  State<VwLogin> createState() => _VwLoginState();
}

class _VwLoginState extends State<VwLogin> {
  @override
  final VmSignUp l_VmSignUp = Get.put(VmSignUp());
  bool G_isChecked = false;

  void initState() {
    // TODO: implement initState
    l_VmSignUp.FncWebToken();
    super.initState();
  }

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget togglepassword() {
      return IconButton(
        onPressed: () {
          setState(() {
            l_VmSignUp.Pr_boolSecurePassword_wid.value = !l_VmSignUp.Pr_boolSecurePassword_wid.value;
          });
        },
        icon: l_VmSignUp.Pr_boolSecurePassword_wid.value ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        color: Colors.grey,
      );
    }

    Widget _WidgetportraitMode(double Pr_height, Pr_width) {
      return Scaffold(
        body: Container(
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
            child: Stack(
              children: <Widget>[
                Container(
                  height: 500,
                ),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.095),
                    child: Center(
                        child: Text(
                      "Sign In",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    ))),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.160, left: Pr_width * 0.018),
                    child: Text(
                      "Email",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.190),
                  child: Center(
                    child: SizedBox(
                        width: Pr_width * .890,
                        child: TextFormField(
                          controller: passswordController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            hintText: 'Full Name',
                            hintStyle: const TextStyle(color: Colors.black38),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white38)),
                            suffixIcon: const Icon(MdiIcons.account, size: 20, color: Colors.grey),
                          ),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.270, left: Pr_width * 0.018),
                    child: Text(
                      "Password",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.300),
                  child: Center(
                    child: SizedBox(
                        width: Pr_width * .890,
                        child: TextFormField(
                          obscureText: l_VmSignUp.Pr_boolSecurePassword_wid.value,
                          controller: passswordController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(color: Colors.black38),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white38)),
                            prefixIcon: const Icon(MdiIcons.fingerprint, size: 20, color: Colors.grey),
                            suffixIcon: togglepassword(),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.380, left: Pr_width * .002),
                  child: Checkbox(
                      value: G_isChecked,
                      onChanged: (value) {
                        G_isChecked = !G_isChecked;
                        setState(() {});
                      }),
                ),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.398, left: Pr_width * 0.1),
                    child: Text(
                      "Remember Me",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.398, left: Pr_width * 0.6),
                    child: Text(
                      "Forget Password",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black26,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.460),
                  child: Center(
                    child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // <-- Radius
                              ),
                              backgroundColor: Colors.lightBlueAccent),
                          onPressed: () async {
                            await l_VmSignUp.Fnc_ValidateLogin();
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
                    padding: EdgeInsets.only(top: Pr_height * 0.560, right: Pr_width * 0.1),
                    child: Center(
                        child: Text(
                      "Don't have an account?",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    ))),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.564, left: Pr_width * 0.5),
                    child: Center(
                        child: InkWell(
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
                    ))),
              ],
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
