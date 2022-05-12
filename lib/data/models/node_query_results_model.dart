import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';

class NodeQueryResultModel extends NodeQueryResult {
  NodeQueryResultModel({required String eonNodeId,required bool connected,
     required List<DeviceQueryResult> deviceQueryResults})
      : super(
        eonNodeId: eonNodeId,
        connected: connected,
        deviceQueryResults: deviceQueryResults,
      );
  factory NodeQueryResultModel.fromJson(Map<String,dynamic> json){
    return NodeQueryResultModel(
      eonNodeId: json['eonNodeId'], 
      connected: json['connected'], 
      deviceQueryResults: json['deviceQueryResults'] == null
          ?[]
          :(json['deviceQueryResults'] as List)
          .map((e) => DeviceQueryResultModel.fromJson(e))
          .toList());
  }
}

class DeviceQueryResultModel extends DeviceQueryResult {
  DeviceQueryResultModel(
      {required String deviceId,
      required bool connected,
      required List<TagQueryResult> tagQueryResults})
      : super(
            deviceId: deviceId,
            connected: connected,
            tagQueryResults: tagQueryResults);
  factory DeviceQueryResultModel.fromJson(Map<String,dynamic> json){
    return DeviceQueryResultModel(
      deviceId: json['deviceId'] as String, 
      connected: bool.fromEnvironment(json['connected'].toString()), 
      tagQueryResults: json['tagQueryResults'] == null
          ?[]
          :(json['tagQueryResults'] as List)
          .map((e) => TagQueryResultModel.fromJson(e))
          .toList());
  }
}

class TagQueryResultModel extends TagQueryResult {
  TagQueryResultModel({required String tagName, required Object value})
      : super(tagName: tagName, value: value);
  factory TagQueryResultModel.fromJson(Map<String,dynamic> json){
    return TagQueryResultModel(
      tagName: json['tagName'],
      value: json['value'],
      );
  }
}
