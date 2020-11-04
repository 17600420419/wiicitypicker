library address_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'address_manager.dart';
import 'city_model.dart';

class Address {
  Province currentProvince;
  City currentCity;
  District currentDistrict;
  Street currentStreet;

  Address(
      {this.currentProvince,
      this.currentCity,
      this.currentDistrict,
      this.currentStreet});
}

class AddressPicker extends StatefulWidget {
  /// 省市区文字显示样式
  final TextStyle style;
  /// 选中的地址发生改变回调
  final ValueChanged<Address> onSelectedAddressChanged;

  AddressPicker(this.style,this.onSelectedAddressChanged);

  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  List<Province> _provinces;

  Province _selectedProvince;
  City _selectedCity;
  District _selectedDistrict;
  Street _selectedStreet;

  FixedExtentScrollController _cityScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _districtScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _streetScrollController =
      FixedExtentScrollController(initialItem: 0);
  @override
  void dispose() {
    _cityScrollController.dispose();
    _districtScrollController.dispose();
    _streetScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getAddressData();
  }

  void _getAddressData() async {
    var addressData = await AddressManager.loadAddressData(context);
    setState(() {
      _provinces = addressData;
      _selectedProvince = _provinces.first;
      _selectedCity = _selectedProvince.areas.first;
      _selectedDistrict = _selectedCity.areas.first;
      _selectedStreet = _selectedDistrict.areas.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_provinces == null || _provinces.isEmpty) {
      return Container();
    }

    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            createTitle(),
            createContent(),
          ],
        ));
  }

  createTitle() {
    return Container(
      height: 50,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 0,
            child: new GestureDetector(
                onTap: respondsToCancel,
                behavior: HitTestBehavior.opaque,
                child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "取消",
                      style: new TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ))),
          ),
          Positioned(
            right: 0,
            child: new GestureDetector(
                onTap: respondsToOk,
                behavior: HitTestBehavior.opaque,
                child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: new Text(
                      "确定",
                      style: new TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ))),
          ),
        ],
      ),
    );
  }

  createContent() {
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CupertinoPicker.builder(
                backgroundColor: Colors.white,
                childCount: _provinces?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = _provinces[index];
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: widget.style,
                    ),
                  );
                },
                itemExtent: 44,
                onSelectedItemChanged: (item) {
                  setState(() {
                    _selectedProvince = _provinces[item];
                    _selectedCity = _selectedProvince.areas.first;
                    _selectedDistrict = _selectedCity.areas.first;
                    if (_selectedDistrict.areas == null) {
                      _selectedDistrict.areas = new List();
                      _selectedDistrict.areas
                          .add(Street(code: "", name: "全部", pinyin: "quanbu"));
                    }
                    _selectedStreet = _selectedDistrict.areas.first;
                    _cityScrollController.animateToItem(0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 250));
                    _districtScrollController.animateToItem(0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 250));
                    _streetScrollController.animateToItem(0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 250));
                  });
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: CupertinoPicker.builder(
                  scrollController: _cityScrollController,
                  backgroundColor: Colors.white,
                  childCount: _selectedProvince?.areas?.length ?? 0,
                  itemBuilder: (context, index) {
                    var item = _selectedProvince.areas[index];
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.style,
                      ),
                    );
                  },
                  itemExtent: 44,
                  onSelectedItemChanged: (item) {
                    setState(() {
                      _selectedCity = _selectedProvince.areas[item];
                      _selectedDistrict = _selectedCity.areas.first;
                      if (_selectedDistrict.areas == null) {
                        _selectedDistrict.areas = new List();
                        _selectedDistrict.areas.add(
                            Street(code: "", name: "全部", pinyin: "quanbu"));
                      }
                      _selectedStreet = _selectedDistrict.areas.first;
                      _districtScrollController.animateToItem(0,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 250));
                      _streetScrollController.animateToItem(0,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 250));
                    });
                  },
                )),
            Expanded(
              flex: 1,
              child: CupertinoPicker.builder(
                scrollController: _districtScrollController,
                backgroundColor: Colors.white,
                childCount: _selectedCity?.areas?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = _selectedCity.areas[index];
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: widget.style,
                    ),
                  );
                },
                itemExtent: 44,
                onSelectedItemChanged: (item) {
                  setState(() {
                    _selectedDistrict = _selectedCity.areas[item];
                    if (_selectedDistrict.areas == null) {
                      _selectedDistrict.areas = new List();
                      _selectedDistrict.areas
                          .add(Street(code: "", name: "全部", pinyin: "quanbu"));
                    }
                    _selectedStreet = _selectedDistrict.areas.first;
                    _streetScrollController.animateToItem(0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 250));
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: CupertinoPicker.builder(
                scrollController: _streetScrollController,
                backgroundColor: Colors.white,
                childCount: _selectedDistrict?.areas?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = _selectedDistrict.areas[index];
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: widget.style,
                    ),
                  );
                },
                itemExtent: 44,
                onSelectedItemChanged: (item) {
                  setState(() {
                    if (_selectedDistrict.areas != null) {
                      _selectedStreet = _selectedDistrict.areas[item];
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void respondsToCancel() {
    Navigator.of(context).pop();
  }

  void respondsToOk() {
    if (widget.onSelectedAddressChanged != null) {
      var address = Address(
          currentProvince: _selectedProvince,
          currentCity: _selectedCity,
          currentDistrict: _selectedDistrict,
          currentStreet: _selectedStreet);
      widget.onSelectedAddressChanged(address);
    }
    Navigator.of(context).pop();
  }
}
