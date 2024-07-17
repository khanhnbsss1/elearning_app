
class PermissionManager {
  static final PermissionManager _singletonPermissionManager = PermissionManager._internal();
  static PermissionManager get getInstance => _singletonPermissionManager;
  factory PermissionManager() {
    return _singletonPermissionManager;
  }
  PermissionManager._internal();

  ProductType _productType = ProductType.webUserVersion;
  
  void setProductType(ProductType productType){
    _productType = productType;
  }
  ProductType getProductType(){
    return _productType;
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
