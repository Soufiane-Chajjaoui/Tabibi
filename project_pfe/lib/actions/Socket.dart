import 'package:project_pfe/actions/Message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socketmanager {
  static IO.Socket? socket;
  static ConnectionSocket() async {
    final _pref = await SharedPreferences.getInstance();
    final id = await _pref.getString("_id");
    socket = IO.io(
        "http://192.168.1.3:8080",
        IO.OptionBuilder()
            .setTransports(['websocket']).setQuery({'idSender': id}).build());
    socket!.onConnect((data) => {print('connection established')});
  }

  static SendMessage(MessageChat message) {
    socket?.emit('/message', message.toJson());
  }

 
}
