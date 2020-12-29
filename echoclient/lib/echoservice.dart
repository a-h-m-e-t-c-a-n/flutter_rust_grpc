import 'package:echoclient/proto/echo.pb.dart';
import 'package:echoclient/proto/echo.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class EchoService {
  static EchoClient client;

  EchoService() {

    client = EchoClient(
      ClientChannel(
        "192.168.1.33",
        port: 50051,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      ),
    );
  }

  Future<EchoReply> commitMessage(String body) async {
    return client.do_echo(
      EchoRequest()
        ..sourceContent=body
        
    );
  }
}