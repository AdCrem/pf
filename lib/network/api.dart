import 'package:dio/dio.dart';
import 'package:pf/model/api_response/api_response.dart';
import 'package:pf/model/pathfinding_query/pathfinding_request.dart';
import 'package:pf/network/dio_client/dio_client.dart';

import '../model/result/result_payload.dart';

class PathFinderApi {
  final DioClient _dioClient;

  PathFinderApi(this._dioClient);

  Future<ApiResponse<List<MapData>>> fetchQueries(String url) async {
    try {
      final res = await _dioClient.get(
        url,
      );

      return ApiResponse.fromJson(
        res,
        (res) => res['data'].map<MapData>((element) {
          return MapData.fromJson(element);
        }).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse.fromJson(e.response?.data, (p0) => []);
    }
  }

  Future<ApiResponse<dynamic>> postResults(List<ResultPayload> payloads, String url) async {
    try {
      final res = await _dioClient.post(
        url,
        data: payloads.map((e) => e.toJson()).toList(),
      );
      return ApiResponse.fromJson(res, (res) => res['data']);
    } on DioException catch (e) {
      return ApiResponse.fromJson(e.response?.data, (p0) => []);
    }
  }
}
