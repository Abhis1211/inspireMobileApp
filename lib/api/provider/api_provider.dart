import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:public_housing/api/api_helper/api_base_helper_implementation.dart';
import 'package:public_housing/api/provider/status_objects.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/building_standards_screen/models/deficiency_areas_res_model.dart';

import '../../screens/auth/model/LoginModel.dart';

class ApiProviders {
  ApiBaseHelperImplementation apiBaseHelperImplementation =
      ApiBaseHelperImplementation();

  ApiProviders();

  Future<Either<Failure, DeficiencyAreasResponseModel>>
      getDeficiencyAreasRequest() async {
    try {
      Response response = await apiBaseHelperImplementation.get(
        endPoint: "deficiency_areas/",
        headers: {
          'Authorization': 'Token 6ace4a1b46b1bd1eee6ee162f88290d4db987913',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(DeficiencyAreasResponseModel.fromJson(response.data));
      } else {
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.response?.data['message']));
    }
  }

  Future<Either<Failure, Loginmodel>> login(mapjson) async {
    try {
      Response response = await apiBaseHelperImplementation.post(
          endPoint: Constants.login, body: mapjson);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(Loginmodel.fromJson(response.data));
      } else {
        print("asdsadas" + response.statusCode.toString());
        return Left(Failure(errorMessage: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.response?.data['detail']));
    }
  }
}