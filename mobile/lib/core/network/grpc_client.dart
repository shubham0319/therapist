import 'package:grpc/grpc.dart';

/// Wraps the gRPC channel and exposes a single shared [ClientChannel].
/// All generated stubs are created from this one channel.
class GrpcClient {
  GrpcClient({required String host, required int port})
      : _channel = ClientChannel(
          host,
          port: port,
          options: ChannelOptions(
            // Use TLS in production, insecure in dev (emulator hits localhost)
            credentials: port == 443
                ? const ChannelCredentials.secure()
                : const ChannelCredentials.insecure(),
            idleTimeout: const Duration(minutes: 5),
            connectionTimeout: const Duration(seconds: 10),
          ),
        );

  final ClientChannel _channel;

  ClientChannel get channel => _channel;

  Future<void> shutdown() => _channel.shutdown();
}
