
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/services/apis/permission/permission_list_api.dart';
import 'package:webkit/services/apis/roles/get_role_list.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';

class PermissionManager {
  static final PermissionManager _singletonPermissionManager = PermissionManager._internal();
  static PermissionManager get getInstance => _singletonPermissionManager;
  factory PermissionManager() {
    return _singletonPermissionManager;
  }
  PermissionManager._internal();

  ProductType _productType = ProductType.webUserVersion;
  PermissionListResponseModel? permissionResponseModel;
  RolesListResponseModel? rolesListResponseModel;
  void setProductType(ProductType productType){
    _productType = productType;
  }
  ProductType getProductType(){
    return _productType;
  }


  Future<PermissionListResponseModel?> getPermissionModel({bool? isRefresh}) async{
    isRefresh??=false;
/*    if(permissionResponseModel==null || (permissionResponseModel?.content??[]).isEmpty || isRefresh)
      {*/
        UserProfile? userProfile = UserManager().getUserProfile();
        GetPermissionListByRoleApi courseApi = GetPermissionListByRoleApi(roleId: userProfile?.roleId);
        permissionResponseModel = await courseApi.call();
      //}
    return permissionResponseModel;
  }
  
  Future<RolesListResponseModel?>getRoleModel() async{
    if(rolesListResponseModel==null)
    {
      GetRoleListApi courseApi = GetRoleListApi();
      rolesListResponseModel = await courseApi.call();
    }
    return rolesListResponseModel;
  }

}

/// Loai product duoc phat trien
enum ProductType {
  webAdminVersion,/// product voi full cac tinh nang va them tinh nang admin
  webUserVersion,/// product voi full cac tinh nang
  mobileUserVersion
}

const Map<ProductType, String> mapProductTypeFlavorName = {
  ProductType.webUserVersion:"webAdmin",
  ProductType.webAdminVersion:"webUser",
  ProductType.mobileUserVersion:"mobileUser",

};
