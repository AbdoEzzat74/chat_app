import '../const/const.dart';

class MessageModel {
  final String messageModel;
  final String id ;
  MessageModel(this.messageModel , this.id);

  factory MessageModel.fromJson(jsonData)
  {
    return MessageModel(jsonData[kMessage],jsonData['id']);
    
  }
}