import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/MVVM/View/VwLogin.dart';
import 'package:login/MVVM/ViewModel/VmPassword.dart';

class VwForgetPasswrod extends StatefulWidget {
  const VwForgetPasswrod({Key? key}) : super(key: key);

  @override
  State<VwForgetPasswrod> createState() => _VwForgetPasswrodState();
}

class _VwForgetPasswrodState extends State<VwForgetPasswrod> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Vmpassword l_Vmpassword = Get.put(Vmpassword());
  final TextEditingController EmailController = TextEditingController();

  Widget build(BuildContext context) {
    EmailController.text = l_Vmpassword.Pr_txtemail_Text;

    Widget _WidgetportraitMode(double Pr_height, Pr_width) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => VwLogin());
            },
          ),
        ),
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
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Pr_height * 0.05,
                  ),
                  Image.asset(
                    "assets/pass.png",
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.04),
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
                    padding: EdgeInsets.only(top: Pr_height * 0.02),
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
                    padding: EdgeInsets.only(top: Pr_height * 0.05),
                    child: Center(
                      child: SizedBox(
                          width: Pr_width * .890,
                          child: TextFormField(
                              controller: EmailController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[50],
                                hintText: 'Enter Your Email',
                                hintStyle: const TextStyle(color: Colors.black38),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: l_Vmpassword.Pr_autoValidate.value &&
                                            l_Vmpassword.Pr_validateEmail(EmailController.text) != null
                                        ? Colors.red
                                        : Colors.white38,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey),
                              ),
                              validator: l_Vmpassword.Pr_validateEmail,
                              onChanged: (value) {
                                l_Vmpassword.Pr_txtemail_Text = value;
                              })),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.03),
                    child: Center(
                      child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12), // <-- Radius
                                ),
                                backgroundColor: Colors.lightBlueAccent),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                //Show a snackbar message asking the user to fill these fields
                              } else {
                                l_Vmpassword.Pr_autoValidate.value = true;
                              }

                              //await l_VmSignUp.Fnc_ValidateLogin();
                              // Get.to(() => VwCompany());
                            },
                            child: Text(
                              "Send Link",
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
