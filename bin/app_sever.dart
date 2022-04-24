import 'dart:io';

class Server {
  Future<HttpServer> createServer({int port = 8080}) async {
    final address = InternetAddress.loopbackIPv4;
    return await HttpServer.bind(address, port);
  }
}

void main(List<String> arguments) async {
  final Server servApp = Server();
  final server = await servApp.createServer();
  print("Address : ${server.address}  port : ${server.port}");
  await handleRequests(server);
}

Future<void> handleRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        handelGet(request);
        break;
      default:
    }
  }
}

void handelGet(HttpRequest request) {
  final path = request.uri.path;
  switch (path) {
    case '/exit':
      request.response
        ..write("bye")
        ..close();
      exit(12);
      break;
    default:
      request.response
        ..statusCode = HttpStatus.notFound
        ..close();
      break;
  }
}
