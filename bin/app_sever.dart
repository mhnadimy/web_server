import 'dart:io';

class Server {
  Future<HttpServer> createServer(
      {required InternetAddress address, port = 8080}) async {
    return await HttpServer.bind(address, port);
  }
}

void main(List<String> arguments) async {
  final Server servApp = Server();
  final server = await servApp.createServer(
      address: InternetAddress("127.0.0.1"), port: 4040);
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
