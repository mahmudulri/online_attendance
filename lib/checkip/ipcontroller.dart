import 'package:get/get.dart';
import 'ipmodel.dart';
import 'ipnetwork.dart';

class MyipController extends GetxController {
  @override
  void onInit() {
    ipmyfunction();
    super.onInit();
  }

  var isLoading = true.obs;
  var myipdetails = MyipModel().obs;
  String? ipaddress = "43.245.123.233";
  String? mypersonalip = "43.245.123.233";

  void ipmyfunction() async {
    try {
      isLoading(true);
      var results = await MyipApi.fetchIPdata();
      if (results != null) {
        myipdetails.value = results;

        isLoading(false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
