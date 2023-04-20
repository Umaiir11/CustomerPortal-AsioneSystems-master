import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login/MVVM/View/VwLogin.dart';
import 'package:login/MVVM/ViewModel/VmPassword.dart';
import 'package:lottie/lottie.dart';

class VwForgetPass extends StatefulWidget {
  const VwForgetPass({Key? key}) : super(key: key);

  @override
  State<VwForgetPass> createState() => _VwForgetPassState();
}

class _VwForgetPassState extends State<VwForgetPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Vmpass l_Vmpass = Get.put(Vmpass());
  final TextEditingController EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EmailController.text = l_Vmpass.Pr_txtemail_Text;

    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => VwLogin());
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: PrHeight,
            width: PrWidth,
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
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: PrHeight * 0.05,
                  ),
                  SizedBox(
                    width: 220,
                    height: 170,
                    child: Lottie.asset('assets/pass.json', fit: BoxFit.cover, repeat: false),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: PrHeight * 0.04),
                    child: Center(
                      child: Text(
                        "Reset Password",
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: PrHeight * 0.02),
                    child: Center(
                      child: Text(
                        "Please enter your email to reset your password. We will send you a secure link to reset your password. Please do not share this link with anyone.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: PrHeight * 0.05),
                    child: Center(
                      child: SizedBox(
                          width: PrWidth * .890,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: EmailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: 'Enter Your Email',
                              hintStyle: const TextStyle(color: Colors.black38),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                              prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              l_Vmpass.Pr_txtemail_Text = value;
                              bool emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
                              if (!emailValid) {
                                return ' Please enter valid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              l_Vmpass.Pr_txtemail_Text = value;
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: PrHeight * 0.03),
                    child: Center(
                      child: SizedBox(
                          width: 200,
                          height: 50,
                          child: Obx(() {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                animationDuration: const Duration(seconds: 2),
                                shape: l_Vmpass.Pr_isLoading_wid.value
                                    ? RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                backgroundColor: Colors.cyan,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await l_Vmpass.FncForgetPassword() == true) {
                                    Get.snackbar(
                                      'Check Gmail',
                                      '',
                                      messageText: const Text(
                                        'Email Sent Successfully',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      snackStyle: SnackStyle.FLOATING,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(10),
                                      borderRadius: 10,
                                      animationDuration: const Duration(milliseconds: 800),
                                      overlayBlur: 0,
                                      isDismissible: true,
                                      mainButton: TextButton(
                                        onPressed: () {
                                          // Do something when main button is pressed
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      '',
                                      messageText: const Text(
                                        'Email with this user does not exist!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      snackStyle: SnackStyle.FLOATING,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(10),
                                      borderRadius: 10,
                                      animationDuration: const Duration(milliseconds: 800),
                                      overlayBlur: 0,
                                      isDismissible: true,
                                      mainButton: TextButton(
                                        onPressed: () {
                                          // Do something when main button is pressed
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                } else {
                                  l_Vmpass.Pr_autoValidate.value = true;
                                }

                                //await l_VmSignUp.Fnc_ValidateLogin();
                                // Get.to(() => VwCompany());
                              },
                              child: l_Vmpass.Pr_isLoading_wid.value
                                  ? LoadingAnimationWidget.twistingDots(
                                      leftDotColor: const Color(0xFF1A1A3F),
                                      rightDotColor: const Color(0xFFFFFFFF),
                                      size: 40,
                                    )
                                  : Text(
                                      "Send Link",
                                      style: GoogleFonts.ubuntu(
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.w600,
                                              letterSpacing: .5)),
                                    ),
                            );
                          })),
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
