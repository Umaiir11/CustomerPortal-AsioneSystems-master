import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../MVVM/Model/ApiModels/ModCountry.dart';

class UWCountryDropDown extends StatelessWidget {
  UWCountryDropDown({
    this.items,
    this.itemAsString,
    this.onChanged,
    this.labelText,
    this.hintText,
  });

  final List<ModCountry>? items;
  final String Function(ModCountry)? itemAsString;
  final void Function(ModCountry?)? onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    InputDecoration l_InputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      hintText: 'Select Your Country',
      hintStyle: const TextStyle(color: Colors.black38),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide:BorderSide.none,),
      prefixIcon: null,
    );

    return DropdownSearch<ModCountry>(
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

  Widget _customDropDownPrograms(BuildContext context, ModCountry? item) {
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
                          item!.Pr_CountryID,
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

  Widget _customPopupItemBuilder(BuildContext context, ModCountry? item, bool isSelected) {
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
                    item!.Pr_CountryID.toString(),
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
