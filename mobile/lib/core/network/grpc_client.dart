import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

/// Wraps the gRPC channel.
///
/// On Flutter web  → uses [GrpcWebClientChannel] (HTTP/1.1 + gRPC-web protocol)
///                    pointing at the gRPC-web port (8080).
/// On native       → uses [ClientChannel] (HTTP/2 native gRPC)
///                    pointing at the gRPC port (50051).
class GrpcClient {
  GrpcClient({
    required String host,
    required int port,
    required int webPort,
  }) : _channel = kIsWeb
            ? GrpcWebClientChannel.xhr(
                Uri(
                  scheme: port == 443 ? 'https' : 'http',
                  host: host,
                  port: webPort,
                ),
              )
            : ClientChannel(
                host,
                port: port,
                options: ChannelOptions(
                  credentials: port == 443
                      ? const ChannelCredentials.secure()
                      : const ChannelCredentials.insecure(),
                  idleTimeout: const Duration(minutes: 5),
                  connectionTimeout: const Duration(seconds: 10),
                ),
              );

  final ClientChannelBase _channel;

  ClientChannelBase get channel => _channel;

  Future<void> shutdown() => _channel.shutdown();
}
