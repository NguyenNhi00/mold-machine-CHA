import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injection_molding_machine_application/data/models/product_model.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';

class MachineService {
  Future<List<ProductModel>> getMachinesData() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl),
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
}
