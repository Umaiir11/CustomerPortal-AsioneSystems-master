import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../MVVM/Model/ApiModels/ModCities.dart';
import '../MVVM/ViewModel/VmSignup.dart';


class UWCitiesDropDown extends StatelessWidget {
  VmSignUp l_VmSignUp = Get.find<VmSignUp>();

  UWCitiesDropDown({
    this.items,
    this.itemAsString,
    this.onChanged,
    this.labelText,
    this.hintText, String? value,
  });

  final List<ModCities>? items;
  final String Function(dynamic)? itemAsString;
  final void Function(ModCities?)? onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    InputDecoration l_InputDecoration = InputDecoration(
      fillColor: Colors.grey[50],
      hintText: 'Select Your City',
      hintStyle: const TextStyle(color: Colors.black38),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white38)
      ),
      prefixIcon: null,
    );


    return DropdownSearch<ModCities>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: l_InputDecoration,
      ),
      popupProps: PopupProps.menu(
        itemBuilder: _customPopupItemBuilder,
        fit: FlexFit.tight,
        showSearchBox: true,
      ),
      // dropdownBuilder: _customDropDownPrograms,
      items: items!,
      itemAsString: itemAsString,
      onChanged: onChanged,
    );
  }

  Widget _customDropDownPrograms(BuildContext context, ModCities? item) {
    return Container(
      child: (item == null)
          ? const ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("Select Country",
            textAlign: TextAlign.start, style: TextStyle(fontSize: 16, color: Color.fromARGB(235, 158, 158, 158))),
      )
          : Row(
        children: [
          Expanded(
            flex: 2,
            child: ListTile(
              title: Wrap(
                spacing: 8,
                children: [
                  Text(
                    item!.Pr_CityID,
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customPopupItemBuilder(BuildContext context, ModCities? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListTile(
              title: Wrap(
                spacing: 8,
                children: [
                  Text(
                    item!.Pr_CityID,
                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
