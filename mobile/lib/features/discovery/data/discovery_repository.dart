import 'package:grpc/service_api.dart';
import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';
import 'package:therapist/core/proto/discovery.pb.dart';

const _kRpcTimeout = Duration(seconds: 15);

class TherapistCardModel {
  const TherapistCardModel({
    required this.therapistId,
    required this.fullName,
    required this.bio,
    required this.profilePhoto,
    required this.specializations,
    required this.sessionFee,
    required this.sessionTypes,
    required this.rating,
    required this.totalSessions,
    required this.state,
    required this.nation,
    required this.addressText,
  });

  final String therapistId;
  final String fullName;
  final String bio;
  final String profilePhoto;
  final List<String> specializations;
  final double sessionFee;
  final List<String> sessionTypes;
  final double rating;
  final int totalSessions;
  final String state;
  final String nation;
  final String addressText;

  bool get hasVideo    => sessionTypes.contains('video');
  bool get hasInPerson => sessionTypes.contains('in_person');

  static TherapistCardModel fromProto(TherapistCard pb) => TherapistCardModel(
        therapistId:     pb.therapistId,
        fullName:        pb.fullName,
        bio:             pb.bio,
        profilePhoto:    pb.profilePhoto,
        specializations: List.unmodifiable(pb.specializations),
        sessionFee:      pb.sessionFee,
        sessionTypes:    List.unmodifiable(pb.sessionTypes),
        rating:          pb.rating,
        totalSessions:   pb.totalSessions,
        state:           pb.state,
        nation:          pb.nation,
        addressText:     pb.addressText,
      );
}

class SearchResult {
  const SearchResult({required this.therapists, required this.total});
  final List<TherapistCardModel> therapists;
  final int total;
}

class DiscoveryRepository {
  DiscoveryRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  Future<Result<SearchResult>> searchTherapists({
    required String query,
    String sessionType = '',
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final res = await _stub.searchTherapists(
        SearchTherapistsRequest()
          ..query = query
          ..sessionType = sessionType
          ..page = page
          ..pageSize = pageSize,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(SearchResult(
        therapists: res.therapists.map(TherapistCardModel.fromProto).toList(),
        total: res.total.toInt(),
      ));
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  Future<Result<List<TherapistCardModel>>> getRecommendedTherapists({
    required String state,
    required String nation,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final res = await _stub.getRecommendedTherapists(
        GetRecommendedTherapistsRequest()
          ..state = state
          ..nation = nation
          ..page = page
          ..pageSize = pageSize,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      return Result.success(
        res.therapists.map(TherapistCardModel.fromProto).toList(),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }
}
