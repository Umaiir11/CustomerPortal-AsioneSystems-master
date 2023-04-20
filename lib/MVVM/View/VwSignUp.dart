import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/ClassModules/cmGlobalVariables.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tuple/tuple.dart';

import '../../UserWidgets/UWCitiesDropDown.dart';
import '../../UserWidgets/UWCountryDropDown.dart';
import '../../Validation/Validation.dart';
import '../Model/ApiModels/ModCities.dart';
import '../Model/ApiModels/ModCountry.dart';
import '../Model/ApiModels/ModUser.dart';
import '../ViewModel/VmSignup.dart';
import 'VwLogin.dart';

class VwSignUp extends StatefulWidget {
  @override
  State<VwSignUp> createState() => _VwSignUpState();
}

class _VwSignUpState extends State<VwSignUp> {
  @override
  final VmSignUp l_VmSignUp = Get.put(VmSignUp());
  ModUser l_ModUser = ModUser();

  bool G_isChecked = false;

  void initState() {
    // TODO: implement initState
    l_VmSignUp.Fnc_CountryListdata();
    super.initState();
  }

  @override
  Future<bool> onWillPop() async {
    Get.back();
    return true;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController FullNameController = TextEditingController();
  final TextEditingController ConfirmPassswordController = TextEditingController();
  final TextEditingController ContactCodeController = TextEditingController();
  final TextEditingController PassswordController = TextEditingController();
  final TextEditingController ContactNumberController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ModCountry? Selectedvalue;

  @override
  Widget build(BuildContext context) {
    FullNameController.text = l_VmSignUp.Pr_txtFullname_Text;
    ConfirmPassswordController.text = l_VmSignUp.Pr_txtconfirmpassword_Text;
    ContactCodeController.text = l_VmSignUp.Pr_contactcode_Text;
    PassswordController.text = l_VmSignUp.Pr_txtpassword_Text;
    ContactNumberController.text = l_VmSignUp.Pr_txtcontactnumber_Text;
    EmailController.text = l_VmSignUp.Pr_txtemail_Text;

    Widget togglepassword() {
      return Obx(() {
        return IconButton(
          onPressed: () {
            l_VmSignUp.Pr_boolSecurePassword_wid.value = !l_VmSignUp.Pr_boolSecurePassword_wid.value;
          },
          icon: l_VmSignUp.Pr_boolSecurePassword_wid.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          color:
          l_VmSignUp.Pr_boolSecurePassword_wid.value ? Colors.cyan : Colors.grey, // set the color based on the toggle state
        );
      });
    }

    Widget _WidgetportraitMode(double Pr_height, Pr_width) {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0, // <-- Set elevation to 0
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // <-- Radius
                        ),
                        backgroundColor: Colors.cyan,
                        minimumSize: Size(double.infinity, 50), // <-- Minimum size
                      ),
                      onPressed: () async {
                        // Output: '1e6e505c-6629-4a1a-88ed-0d84c7e246a8'

                        if (_formKey.currentState!.validate()) {
                          if (l_VmSignUp.Pr_selectedcountry_Text.isNotEmpty && l_VmSignUp.Pr_selectedcity_Text.isNotEmpty) {
                            if (l_VmSignUp.G_compressedImage.value == null) {
                              // If no image has been uploaded, show an error message to the user
                              Get.snackbar(
                                'Alert',
                                '',
                                messageText: Text(
                                  'Plaese Upload Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                snackStyle: SnackStyle.FLOATING,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                margin: EdgeInsets.all(10),
                                borderRadius: 10,
                                animationDuration: Duration(milliseconds: 800),
                                overlayBlur: 0,
                                isDismissible: true,
                                mainButton: TextButton(
                                  onPressed: () {
                                    // Do something when main button is pressed
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                              );
                              return;
                            }

                            // Clear the model data
                            l_VmSignUp.lModuserlist.clear();
                            // Fill the model data with the new form data
                            l_VmSignUp.FncFillModelData();

                            if (l_VmSignUp.lModuserlist.isNotEmpty) {
                              l_VmSignUp.Fnc_SendEmail();
                              if (await l_VmSignUp.Fnc_CheckDuplicate() == true) {
                                Get.snackbar(
                                  'Alert',
                                  '',
                                  messageText: Text(
                                    'This user already exists. Please try again with a different email or log in using your existing account',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  snackStyle: SnackStyle.FLOATING,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: EdgeInsets.all(10),
                                  borderRadius: 10,
                                  animationDuration: Duration(milliseconds: 800),
                                  overlayBlur: 0,
                                  isDismissible: true,
                                  mainButton: TextButton(
                                    onPressed: () {
                                      // Do something when main button is pressed
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                if (await l_VmSignUp.Fnc_UserCreate() == true) {
                                  Get.snackbar(
                                    'Alert',
                                    '',
                                    messageText: Text(
                                      'User Created',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    snackStyle: SnackStyle.FLOATING,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.black87,
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    animationDuration: Duration(milliseconds: 800),
                                    overlayBlur: 0,
                                    isDismissible: true,
                                    mainButton: TextButton(
                                      onPressed: () {
                                        // Do something when main button is pressed
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  Get.snackbar(
                                    'Alert',
                                    '',
                                    messageText: Text(
                                      'User Not Created',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    snackStyle: SnackStyle.FLOATING,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    animationDuration: Duration(milliseconds: 800),
                                    overlayBlur: 0,
                                    isDismissible: true,
                                    mainButton: TextButton(
                                      onPressed: () {
                                        // Do something when main button is pressed
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }
                            } else {
                              print('List Empty');
                            }
                          } else {
                            // Show a snackbar message asking the user to fill these fields
                            Get.snackbar(
                              'Alert',
                              '',
                              messageText: Text(
                                'Please select both a country and a city',
                                style: TextStyle(color: Colors.white),
                              ),
                              snackStyle: SnackStyle.FLOATING,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              animationDuration: Duration(milliseconds: 800),
                              overlayBlur: 0,
                              isDismissible: true,
                              mainButton: TextButton(
                                onPressed: () {
                                  // Do something when main button is pressed
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            );
                          }
                        } else {
                          l_VmSignUp.l_autoValidate.value = true;
                        }
                      },
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: .5,
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
                  SizedBox(
                    height: Pr_height * 0.04,
                  ),
                  Center(
                    child: Text(
                      "Tap to upload image",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black38,
                              //fontWeight: FontWeight.w600,
                              letterSpacing: .5)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01, left: Pr_width * 0.028),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () async {
                              if (await l_VmSignUp.FncUserImage() == true) {
                                Get.snackbar(
                                  'Image Alert',
                                  '',
                                  messageText: Text(
                                    'Image compressed to ${l_VmSignUp.G_compressedSize.value ~/
                                        1024} KB. | Image extension: ${cmGlobalVariables.Pb_ImageExt}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  snackStyle: SnackStyle.FLOATING,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  colorText: Colors.white,
                                  margin: EdgeInsets.all(10),
                                  borderRadius: 10,
                                  animationDuration: Duration(milliseconds: 800),
                                  overlayBlur: 0,
                                  isDismissible: true,
                                  mainButton: TextButton(
                                    onPressed: () {
                                      // Do something when main button is pressed
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                Get.snackbar("ALert", "Upload image");
                              }
                            },
                            child: Obx(
                                  () =>
                              l_VmSignUp.G_compressedImage.value != null
                                  ? Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(File(l_VmSignUp.G_compressedImage.value!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                                  : SizedBox(
                                width: 140,
                                height: 120,
                                child: Lottie.asset(
                                  'assets/upload.json',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Obx(() => Text(l_VmSignUp.Pr_imageName.value)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.030),
                    child: Center(
                      child: SizedBox(
                        width: Pr_width * .890,
                        child: TextFormField(
                            controller: FullNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: 'Full Name',
                              hintStyle: const TextStyle(color: Colors.black38),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                            ),
                            validator: (value) {
                              l_ModUser.Pr_FullName = value ?? '';
                              Tuple2<List<String>?, List<String>?> errors = DVMUser.Fnc_Validate(l_ModUser);
                              if (errors.item2 != null && errors.item2!.contains('Pr_FullName')) {
                                return errors.item1![errors.item2!.indexOf(
                                    'Pr_FullName')]; // Return the error message for Pr_FullName
                              }

                              return null;
                            },
                            onChanged: (value) {
                              l_VmSignUp.Pr_txtFullname_Text = value;
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01),
                    child: Center(
                        child: SizedBox(
                            width: Pr_width * .890,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: EmailController,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[100],
                                filled: true,
                                hintText: 'Enter Email',
                                hintStyle: const TextStyle(color: Colors.black38),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                                suffixIcon: const Icon(MdiIcons.account, size: 20, color: Colors.grey),
                              ),
                              validator: (value) {
                                l_ModUser.Pr_EmailID = value ?? '';
                                Tuple2<List<String>?, List<String>?> errors = DVMUser.Fnc_Validate(l_ModUser);
                                if (errors.item2 != null && errors.item2!.contains('Pr_EmailID')) {
                                  return errors.item1![errors.item2!.indexOf(
                                      'Pr_EmailID')]; // Return the error message for Pr_EmailID
                                }

                                return null;
                              },

                              onChanged: (value) {
                                l_VmSignUp.Pr_txtemail_Text = value;
                              },
                            ))),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01),
                    child: Center(
                      child: SizedBox(
                          width: Pr_width * .890,
                          child: Obx(() {
                            return TextFormField(
                              obscureText: !l_VmSignUp.Pr_boolSecurePassword_wid.value,
                              controller: PassswordController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(color: Colors.black38),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                                suffixIcon: togglepassword(),
                              ),
                              validator: (value) {
                                l_ModUser.Pr_Password = value ?? '';
                                Tuple2<List<String>?, List<String>?> errors = DVMUser.Fnc_Validate(l_ModUser);
                                if (errors.item2 != null && errors.item2!.contains('Pr_Password')) {
                                  return errors.item1![errors.item2!.indexOf(
                                      'Pr_Password')]; // Return the error message for Pr_EmailID
                                }

                                return null;
                              },
                              onChanged: (value) {
                                l_VmSignUp.Pr_txtpassword_Text = value;
                              },
                            );
                          })),
                    ),
                  ),

                  //DropDowns
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: Pr_width * .890,
                        height: Pr_height * .070,
                        child: UWCountryDropDown(
                          items: l_VmSignUp.l_PrCountriesList,
                          itemAsString: (l_CountriesList) => '${l_CountriesList.Pr_CountryID}',
                          onChanged: (ModCountry? l_SelectedCountry) async {
                            l_VmSignUp.Pr_selectedcountry_Text = l_SelectedCountry!.Pr_CountryID;
                            l_VmSignUp.Pr_selectedautoid_Text = l_SelectedCountry!.Pr_AutoID;

                            if (l_VmSignUp.Pr_selectedcountry_Text != null) {
                              cmGlobalVariables.Pb_SelectedCity = l_SelectedCountry!.Pr_AutoID;
                              l_VmSignUp.Pr_contactcode_Text = l_SelectedCountry!.Pr_CountryCode;

                              // Clear the city list
                              l_VmSignUp.l_PrCitiesList?.clear();
                              // Call a method to fetch the city data
                              if (await l_VmSignUp.Fnc_CitiesListdata()) {
                                // l_VmSignUp.Pr_selectedcity_Text = l_VmSignUp.l_PrCitiesList![0].Pr_CityID;
                                //print("selected city is: ${l_VmSignUp.Pr_selectedcity_Text}");
                              }
                              print("selected country: ${l_VmSignUp.Pr_selectedcountry_Text}");
                              print("selected country Code: ${l_VmSignUp.Pr_contactcode_Text}");
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: Pr_width * .890,
                        height: Pr_height * .070,
                        child: UWCitiesDropDown(
                          items: l_VmSignUp.l_PrCitiesList,
                          itemAsString: (l_CitiesList) => '${l_CitiesList.Pr_CityID}',
                          onChanged: (ModCities? l_SelectedCity) {
                            l_VmSignUp.Pr_selectedcity_Text = l_SelectedCity!.Pr_CityID;
                            if (l_VmSignUp.Pr_selectedcity_Text != null) {
                              print("selected City: ${l_VmSignUp.Pr_selectedcity_Text}");
                            }
                          },
                          // set the initial default value here
                        ),
                      ),
                    ),
                  ),

//Row
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.01, left: Pr_width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Pr_width * .290,
                                child: Obx(() {
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText:
                                      '${l_VmSignUp.Pr_contactcode_Text.isEmpty ? '+00' : l_VmSignUp.Pr_contactcode_Text}',
                                      hintStyle: const TextStyle(color: Colors.black38),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                                    ),
                                    enabled: false, // make the text field uneditable
                                  );
                                })),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: Pr_width * .590,
                                child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: ContactNumberController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: 'Contact Number',
                                      hintStyle: const TextStyle(color: Colors.black38),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
                                    ),
                                    validator: (value) {
                                      l_ModUser.Pr_ContactNo = value ?? '';
                                      Tuple2<List<String>?, List<String>?> errors = DVMUser.Fnc_Validate(l_ModUser);

                                      if (errors.item2 != null && errors.item2!.contains('Pr_ContactNo')) {
                                        return errors.item1![
                                        errors.item2!.indexOf('Pr_ContactNo')]; // Return the error message for Pr_ContactNo
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      l_VmSignUp.Pr_txtcontactnumber_Text = value;
                                    })),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///Row
                  Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Already have an account?",
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
                            InkWell(
                              onTap: () {
                                Get.to(() => VwLogin());
                              },
                              child: Text(
                                "Sign in",
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                        //fontWeight: FontWeight.w600,
                                        letterSpacing: .5)),
                              ),
                            )
                          ],
                        ),
                      ],
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
