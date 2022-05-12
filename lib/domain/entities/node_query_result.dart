import 'package:equatable/equatable.dart';

class TagQueryResult extends Equatable {
   String tagName;
   Object value;

   TagQueryResult({
    required this.tagName,
    required this.value,
  });

  @override
  List<Object> get props => [tagName, value];
 
}

class DeviceQueryResult extends Equatable {
 String deviceId;
 bool connected;
 List<TagQueryResult> tagQueryResults;

 DeviceQueryResult({
    required this.deviceId,
    required this.connected,
    required this.tagQueryResults,
  });

  @override
  List<Object> get props =>
      [deviceId, connected, tagQueryResults];
}

class NodeQueryResult extends Equatable {
 String eonNodeId;
 bool connected;
 List<DeviceQueryResult> deviceQueryResults;

 NodeQueryResult({
   required this.eonNodeId,
   required this.connected,
   required this.deviceQueryResults,
});

  @override
  List<Object> get props =>
      [eonNodeId, connected, deviceQueryResults];

 
  }
