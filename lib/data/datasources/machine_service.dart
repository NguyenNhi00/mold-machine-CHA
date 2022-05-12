import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injection_molding_machine_application/data/models/machine_model.dart';
import 'package:injection_molding_machine_application/data/models/product_model.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';

class MachineService {
  Future<List<ProductModel>> getProductData() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrlProduct),
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      print('body: $body');
      List<ProductModel> productData = body
          .map(
            (dynamic item) => ProductModel.fromJson(item),
          )
          .toList();
      print(productData);
      return productData;
    } else {
      print(res.statusCode);
      throw " Unable to retrieve posts.";
    }
  }
  Future<List<MachineModel>> getmachinesData() async{
    final res = await http.get(Uri.parse(Constants.baseUrlMachine));
    if(res.statusCode == 200){
      final body = jsonDecode(res.body);
       List<MachineModel> machinesData = body
          .map(
            (dynamic item) => MachineModel.fromJson(item),
          )
          .toList();
      print('machines: $machinesData');
      return machinesData;
    }else{
      print(res.statusCode);
      throw " Unable to retrieve posts.";
    }
  }
}
