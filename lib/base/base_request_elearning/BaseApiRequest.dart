import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/EnumCommon.dart';
import 'package:lms_app/base/device_elearning/device_manager.dart';
import 'package:lms_app/services_elearning/apis/auth/login/models/login_response.dart';
import '../author/author_manager.dart';
import '../instance_mananger_elearning/instance_mananger.dart';
import '../widgets/common/alert_dialog/NotifyDialog.dart';
import '../widgets/common/alert_dialog/loading.common.dart';
import '../widgets/toast_common/toast_utils.dart';
import 'BaseResponseAPI.dart';
import 'dio_client.dart';
import 'internet_checker_handler.dart';
import 'models/response_error_objects.dart';
export 'package:lms_app/base/base_request_elearning/EnumCommon.dart';
export 'package:lms_app/base/base_request_elearning/apiName.dart';
export 'package:lms_app/base/base_request_elearning/models/response_error_objects.dart';

enum BodyMethod{
  none,
  formData,
  xWwwFromUrlEncode,
  raw,
  binary,
  graphQL
}
class BaseApiRequest {
  Map<String, dynamic>? paramsAdd = HashMap(); // Is a HashMap
  Map<String, dynamic>? requestHeader = HashMap(); // Is a HashMap
  Map<String, dynamic>? requestBody = HashMap(); // Is a HashMap
  Map<String, dynamic>? paramsBase = HashMap(); // Is a HashMap
  Map<String, dynamic>? paramsFinalMap = HashMap(); // Is a HashMap
  String apiName = "";
  String apiPathVariable ="";
  EVIROMENT_DOMAIN? enviromentDomain = EVIROMENT_DOMAIN.LIVE_DOMAIN;
  DOMAIN_TYPE? domainType = DOMAIN_TYPE.MAIN;
  SERVICE_TYPE serviceType = SERVICE_TYPE.AUTHEN;
  bool? isShowErrorPopup;
  bool?isShowToastError;
  bool? isCheckToken;
  BodyMethod? bodyMethod;
  
  static const int timeout = 60;
  BaseApiRequest({
    this.enviromentDomain,
    this.domainType,
    required this.serviceType,
    required this.apiName,
    this.paramsAdd,
    this.requestHeader,
    this.requestBody,
    this.bodyMethod,
    this.isShowErrorPopup,
    this.isCheckToken,
    this.isShowToastError
  }
      ) {
    enviromentDomain??= EVIROMENT_DOMAIN.LIVE_DOMAIN;
    domainType ??=DOMAIN_TYPE.MAIN;
    paramsAdd ??=HashMap();
    requestBody ??=HashMap();
    requestHeader ??=HashMap();
    requestHeader!["Content-Type"] = "application/json";
    isShowErrorPopup=false;
    isShowToastError??=true;
    bodyMethod??=BodyMethod.raw;

  }

  void setDomainType(DOMAIN_TYPE inputDomainType) {
    domainType = inputDomainType;
  }

  Future<DOMAIN_TYPE?> getDomainType() async {
    return domainType;
  }

  void setServiceType(SERVICE_TYPE inputServiceType) {
    serviceType = inputServiceType;
  }

  SERVICE_TYPE? getServiceType() {
    return serviceType;
  }

  void setEnviromentDomain(EVIROMENT_DOMAIN intputEnviromentDomain) {
    enviromentDomain = intputEnviromentDomain;
  }

  EVIROMENT_DOMAIN? getEnviromentDomain() {
    return enviromentDomain;
  }

  Future<String> getDomainStr() async {
    Map<DOMAIN_TYPE, String> domainMapByDomainType = DOMAIN_FINAL[getEnviromentDomain()]!;
    DOMAIN_TYPE? domainType = await getDomainType();
    String domainFinal = domainMapByDomainType[domainType??DOMAIN_TYPE.MAIN]!;
    return domainFinal;
  }

  String getServiceStr() {
    String domainFinal = SERVICE[getServiceType()]!;
    return domainFinal;
  }

  String getAPINameStr() {
    return apiName;
  }

  Future<void> setAPIName(String? apiName) async {
    if (apiName!.isNotEmpty) this.apiName = apiName;
  }

  Future<void> setParamsAdd(Map<String, dynamic> paramsAdd) async {
    this.paramsAdd!.addAll(paramsAdd);
  }

  Future<void> setHeaderAdd(Map<String, dynamic> headersAdd) async {

    requestHeader!.addAll(headersAdd);
  }
  Future<void> setPathVariAble(Map<String, dynamic> apiPathVariable) async {

    if(apiPathVariable.isEmpty) {
      return;
    }
    for(var value in apiPathVariable.values)
    {
      this.apiPathVariable+=("/${value.toString()}");
    }
  }

  Future<Map<String, dynamic>> getHeaderAdd() async {
    AuthInfo? authInfo = AuthorManager().getAuthInfo();
    bool containAuthenParams = requestHeader!.keys.contains("Authorization");
    requestHeader?.addAll({
      "ngrok-skip-browser-warning": true
    });
    if(!containAuthenParams && authInfo!=null)
    {
      requestHeader?.addAll({
      "ngrok-skip-browser-warning": true,
        "Authorization": "Bearer ${authInfo.accessToken}",
        
      });
    }
    DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
    requestHeader?.addAll({
      "Device-Type":deviceInfoModel?.type
    });
    if(!(isCheckToken??true))
    {
      requestHeader?.remove("Authorization");
    }
    //requestHeader?.addAll({'content-type': 'application/json', 'Access-Control-Allow-Origin': "*", "Accept": "*/*"});
    return requestHeader!;
  }

  Future<Map<String, dynamic>> getParamsAdd() async {
    return paramsAdd!;
  }

  Future< dynamic> getBodyAdd() async {
    dynamic bodyFinal;
    switch(bodyMethod){
      case BodyMethod.formData:
      // TODO: Handle this case.
        {
          bodyFinal = FormData.fromMap(requestBody??{},ListFormat.multi,false);
          break;
        }
      case BodyMethod.xWwwFromUrlEncode:
      // TODO: Handle this case.
        bodyFinal = requestBody;
        break;
      case BodyMethod.raw:
      // TODO: Handle this case.
        bodyFinal = requestBody;
        break;
      case BodyMethod.binary:
      // TODO: Handle this case.
        bodyFinal = requestBody;
        break;
      case BodyMethod.graphQL:
      // TODO: Handle this case.
        bodyFinal = requestBody;
        break;
      default:
        break;
    }
    return bodyFinal;
  }

  Future<void> setParamsBase() async {}
  Future<Map<String, dynamic>> getParamsBase() async {
    return paramsBase!;
  }

  Future<Map<String, dynamic>> getParamsFinal() async {
    paramsFinalMap!.addEntries((await getParamsBase()).entries);
    Map<String, dynamic> paramsAdd = await getParamsAdd();
    paramsFinalMap!.addEntries(paramsAdd.entries);
    return paramsFinalMap!;
  }

  Future<String> getParamsFinalStr() async {
    String paramsFinalStr = "";
    //add base params
    Map<String, dynamic> paramsBase = await getParamsBase();

    for (int index = 0; index < paramsBase.length; index++) {
      if (index == 0) {
        paramsFinalStr += "?${paramsBase.entries.elementAt(index).key}";
      } else {
        paramsFinalStr += "&${paramsBase.entries.elementAt(index).key}";
      }
      paramsFinalStr += "=${paramsBase.entries.elementAt(index).value}";
    }
    // add paramsAdd
    Map<String, dynamic> paramsFinal = await getParamsFinal();

    for (int index = 0; index < paramsFinal.length; index++) {
      if (paramsFinalStr.isEmpty) {
        paramsFinalStr += "?${paramsFinal.entries.elementAt(index).key}";
      } else {
        paramsFinalStr += "&${paramsFinal.entries.elementAt(index).key}";
      }
      paramsFinalStr += "=${paramsFinal.entries.elementAt(index).value}";
    }
    return paramsFinalStr;
  }

  Future<String> getFullUrl() async {
    String url = "";
    url += await getDomainStr();
    url += getServiceStr();
    url += getAPINameStr();
    url += apiPathVariable;
    return url;
  }

  Future<void> setApiBody(dynamic bodyAdd) async {
    requestBody!.addAll(bodyAdd);
  }
  Future<dynamic> postRequestAPI() async {
    bool isConnectInternet = await InternetCheckerHandler.getInstance.checkConnectionInternet();
    if(!isConnectInternet){
      return null;
    }
    return await requestPostWithDio();
  }

  Future<dynamic> getRequestAPI() async {
    bool isConnectInternet = await InternetCheckerHandler.getInstance.checkConnectionInternet();
    if(!isConnectInternet){
      return null;
    }
    return await requestGetWithDio();
  }
  Future<dynamic> putRequestAPI() async {
    bool isConnectInternet = await InternetCheckerHandler.getInstance.checkConnectionInternet();
    if(!isConnectInternet){
      return null;
    }
    return await requestPutWithDio();
  }
  Future<dynamic> deleteRequestAPI() async {
    bool isConnectInternet = await InternetCheckerHandler.getInstance.checkConnectionInternet();
    if(!isConnectInternet){
      return null;
    }
    return await requestDeleteWithDio();
  }


  Future<dynamic> requestPostWithHttps() async {
    var requestBodyObj = json.encode(requestBody!);
    String url = await getFullUrl();
    try{
      var response = await http.post(
        Uri.parse(url),
        body: requestBodyObj,
        headers: requestHeader!.map((key, value) => MapEntry(key, value.toString())),
      );
      return await handleResponse(response: response, url: url, option: Options(headers: requestHeader));
    }
    catch(e){
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }
  Future<dynamic> requestGetWithHttps() async {
    String url = await getFullUrl();
    try{
      var response = await http.get(
        Uri.parse(url),
        headers: requestHeader!.map((key, value) => MapEntry(key, value.toString())),
      );
      return await handleResponse(response: response, url: url, option: Options(headers: requestHeader));
    }
    catch(e){
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }
  Future<dynamic> requestDeleteWithHttps() async {
    String url = await getFullUrl();
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: requestHeader!.map((key, value) =>
            MapEntry(key, value.toString())),
      );
      return await handleResponse(response: response, url: url, option: Options(headers: requestHeader));
    }
    catch(e){
      FileUtils.PrintLog(' \n error: $e \n\n');
    }
  }
  Future<dynamic> requestPutWithHttps() async {
    String url = await getFullUrl();
    try{
      var response = await http.put(
        Uri.parse(url),
        headers: requestHeader!.map((key, value) => MapEntry(key, value.toString())),
      );
      return await handleResponse(response: response, url: url, option: Options(headers: requestHeader));
    }
    catch(e){
      handleResponse(response: e, url: url);
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }

  Future<dynamic> requestPostWithDio() async {
    var option = Options(headers: await getHeaderAdd());
    String url = await getFullUrl();
    Map<String, dynamic> params = await getParamsFinal();
    dynamic body = await getBodyAdd();
    try{
      var option = Options(
        headers: await getHeaderAdd(),
        sendTimeout: const Duration(seconds: timeout), // 30 seconds
        receiveTimeout: const Duration(seconds: timeout),
        validateStatus: (_) => true,);

      Response response = await DioClient().getDioClient().post(url, queryParameters: params, data: body, options: option);
      return await handleResponse(response: response, url: url, option: option, params: params, body: body);
    }
    catch(e){
      handleResponse(response: e, url: url,params: params, body: body);
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }

  Future<dynamic> requestGetWithDio() async {
    String url = await getFullUrl();
    Map<String, dynamic> params =  await getParamsFinal();

    DioClient().getDioClient().options = DioClient().getDioClient().options.copyWith(headers: await getHeaderAdd(), validateStatus: (_) => true,);
    try{
      var option = Options(
        headers: await getHeaderAdd(),
        validateStatus: (_) => true,
        receiveDataWhenStatusError: true,
        sendTimeout: const Duration(seconds: timeout), // 30 seconds
        receiveTimeout: const Duration(seconds: timeout), // 3);
      );
      Response response = await DioClient().getDioClient().get(url, queryParameters: params, options: option);
      return await handleResponse(response: response, url: url, params: params);
    }
    catch(e){
      handleResponse(response: e, url: url,params: params,);

      FileUtils.PrintLog(' \n error: $e \n\n');
    }


  }

  Future<dynamic> requestDeleteWithDio() async {
    String url = await getFullUrl();
    Map<String, dynamic> params =  await getParamsFinal();
    DioClient().getDioClient().options = DioClient().getDioClient().options.copyWith(headers: await getHeaderAdd(), validateStatus: (_) => true,);
    try{
      var option = Options(
        headers: await getHeaderAdd(),
        validateStatus: (_) => true,
        receiveDataWhenStatusError: true,
        sendTimeout: const Duration(seconds: timeout), // 30 seconds
        receiveTimeout: const Duration(seconds: timeout), // 3);
      );

      Response response = await DioClient().getDioClient().delete(url, queryParameters: params, options: option);
      return await handleResponse(response: response, url: url, params: params);
    }
    catch(e){
      handleResponse(response: e, url: url,params: params);
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }

  Future<dynamic> requestPutWithDio() async {
    String url = await getFullUrl();
    Map<String, dynamic> params =  await getParamsFinal();
    dynamic body = await getBodyAdd();
    DioClient().getDioClient().options = DioClient().getDioClient().options.copyWith(headers: await getHeaderAdd(), validateStatus: (_) => true,);
    try{
      var option = Options(
        headers: await getHeaderAdd(),
        validateStatus: (_) => true,
        receiveDataWhenStatusError: true,
        sendTimeout: const Duration(seconds: timeout), // 30 seconds
        receiveTimeout: const Duration(seconds: timeout), // 3);
      );
      Response response =  await DioClient().getDioClient().put(url, queryParameters: params, data: body,options: option);
      return await handleResponse(response: response, url: url, params: params, body: body);
    }
    catch(e){
      handleResponse(response: e, url: url,params: params, body: body);
      FileUtils.PrintLog(' \n error: $e \n\n');
    }

  }

  Future<dynamic> handleResponse(
      {
        required var response,
        required String url,
        Options? option,
        Map<String, dynamic> params =const {},
        dynamic body=const{}
      }) async {
    if(response.runtimeType == DioException)
    {
      handleDioExceptionError(error: response);
      return;
    }
    try {
      FileUtils.PrintLog(
          ' url: $url, '
              '\n headers:${option!=null?option.headers:""},'
              '\n params:$params,'
              '\n requestBody:$body,'
              ' \n ressponse: $response \n\n');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Map<String, dynamic> responseBody = response.data;
        ResponseCommon responseCommon = ResponseCommon(
            datetime: responseBody["datetime"],
            data: responseBody["data"],
            errorCode: responseBody["errorCode"],
            message: responseBody["message"],
            success: responseBody["success"]

        );
        if(!responseBody.containsKey("data")) /// truong hop repponse tra ve khong dung dinh dang chung
        {
          ResponseCommon responseCommon = ResponseCommon(
              datetime: null,
              data: responseBody,
              errorCode: null,
              message: null,
              success: null
          );
          return responseCommon;
        }
        if(responseBody["errorCode"]!= "200") /// data tra ve la loi
        {

          handleDataError(responseBody);
          return responseCommon;
        }
        BaseAPIResponse baseAPIResponse = BaseAPIResponse.fromJson(responseBody);
        //ToastUtils.showToastSuccess(baseAPIResponse.message??"", position: ToastGravity.TOP );
        await onRequestSuccess(baseAPIResponse.result);
        return baseAPIResponse.result!;
      }
      else if (response.statusCode == 401 || response.statusCode == 403)// qua han token
          {
        await AuthorManager().refreshToken();
        return ResponseCommon(
            errorCode: response.statusCode,
            message: response.statusMessage,
            success: false,
            data:  null
        );
      }
      else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        MonitorLoading().dismiss();
        FileUtils.PrintLog(
            ' errorUrl: $url, '
                '\n headers:${option!=null?option.headers:""},'
                '\n params:$params,'
                '\n requestBody:$body,'
                ' \n ressponse: $response \n\n');
        if(response.data!=null && response.data!='' && response.data["message"]!=null) {
          response.statusMessage= response.data["message"];
        }
        await onRequestError(response.statusCode, response.statusMessage);
        return ResponseCommon(
            errorCode: response.statusCode.toString(),
            message: response.statusMessage,
            success: false,
            data:  null
        );
      }
    } catch (e) {
      MonitorLoading().dismiss();
      FileUtils.PrintLog(
          ' errorUrl: $url, '
              '\n headers:${option!=null?option.headers:""},'
              '\n params:$params,'
              '\n requestBody:$body,'
              ' \n error: $e \n\n');
      if(e.runtimeType == DioException)
      {
        DioException error = e as DioException;
        handleDioExceptionError(error:error );
        return ResponseCommon(
            errorCode: "",
            message: response.statusMessage,
            success: false,
            data:  null
        );
      }
    }
  }
  Future<void> onRequestSuccess(var data) async{}
  Future<void> onRequestError(int? statusCode, String? statusMessage) async{
    onShowError(statusCode, statusMessage);
  }
  Future<void> onShowError(int? statusCode, String? statusMessage) async{
    if(statusMessage==null) {
      return;
    }
    
    if(isShowToastError??true) {
      ToastUtils.showToastError(statusMessage, position: ToastGravity.TOP );
    }
  }

  Future<void> handleDioExceptionError({Response? response,DioException? error}) async {
    ResponseCommon? responseErrorCommon;
    if(error!=null )
    {
      if(error.response!=null)
      {
        responseErrorCommon = ResponseCommon.fromJson(error.response!.data!);
        if(error.response!.statusCode !=null && (error.response!.statusCode ==401 ||error.response!.statusCode ==403 )  )
        {
          await AuthorManager().refreshToken();
        }
      }
      else
      {
        handlerDioExceptionType(error.type);
      }

    }
    else if(response!=null)
    {
      try{
        responseErrorCommon = ResponseCommon.fromJson(response.data!);
      }
      catch(e){
        responseErrorCommon = null;
      }
    }

    if(responseErrorCommon!=null)
    {
      if(isShowErrorPopup!){
        NotifyDialog.showDialogOneButton(description: responseErrorCommon.message);
      }
      else
        {
          ToastUtils.showToastError(responseErrorCommon.message??'');

        }
      await onRequestError(int.tryParse(responseErrorCommon.errorCode??"",), responseErrorCommon.message??"");
    }
  }
  void handlerDioExceptionType(DioExceptionType type){
    String message= S.of(InstanceManager().navigatorKey.currentContext!).no_internet;
    switch (type)
    {
      case DioExceptionType.connectionTimeout:
      // TODO: Handle this case.
      case DioExceptionType.sendTimeout:
      // TODO: Handle this case.
      case DioExceptionType.receiveTimeout:
      // TODO: Handle this case.
        {
          message= S.of(InstanceManager().navigatorKey.currentContext!).time_out_connection;
        }
        break;
      case DioExceptionType.connectionError:
      // TODO: Handle this case.
        {
          message= S.of(InstanceManager().navigatorKey.currentContext!).not_connect_to_server;
        }
        break;
      case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      case DioExceptionType.badResponse:
      // TODO: Handle this case.
      case DioExceptionType.cancel:
      // TODO: Handle this case.
      case DioExceptionType.unknown:
      // TODO: Handle this case.
        {
          message= S.of(InstanceManager().navigatorKey.currentContext!).notify_error;
        }
        break;
    }
    if(isShowErrorPopup!) {
      NotifyDialog.showDialogOneButton(description: message);
    }
    else
      {
        ToastUtils.showToastError(message);
      }

  }
  Future<void> handleDataError(dynamic data) async {
    ResponseCommon requesstResponseErrorModel = ResponseCommon.fromJson(data);
    if(isShowErrorPopup!){
      NotifyDialog.showDialogOneButton(description: requesstResponseErrorModel.message);
    }
    else
      {
        ToastUtils.showToastError(requesstResponseErrorModel.message??'');
      }

    await onRequestError(int.tryParse(requesstResponseErrorModel.errorCode!,), requesstResponseErrorModel.message);
  }
}
