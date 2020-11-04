# wiicitypicker

省市区（县）街道（乡镇）4级地址选择器

## Getting Started

使用方法：
showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
              //设置弹出组件的高度
              height: 300.0,
              child: AddressPicker(
                //设置字体
                TextStyle(color: Colors.black, fontSize: 14),
                //选择的地址信息
                (address) {
                  print(address.currentProvince.code+" "+address.currentProvince.name+" "+address.currentCity.code
                      +" "+address.currentCity.name+" "+address.currentDistrict.code+" "+address.currentDistrict.name+" "
                      +address.currentStreet.code +" "+address.currentStreet.name);
                },
              ),
            )
          )
       );


