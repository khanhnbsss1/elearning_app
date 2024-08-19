class PageModel{
  PageModel({this.total, this.pageSize, this.pageNumber}){
    pageSize??=10;
    total??=0;
    pageNumber ??=10;
  }
  int? total;
  int? pageSize;
  int? pageNumber;
  int getCurrentPage(){
    int pageIndex = ((pageNumber)??1)+1;
    if(getTotalPage()<=pageIndex)
      {
        pageIndex = getTotalPage();
      }
    return pageIndex<1?1:pageIndex;
  }
  int getTotalPage(){
    int totalTemp = (total??1);
    int pageSizeTemp = (pageSize??0)>0?pageSize!:1;
    int totalPage = totalTemp~/pageSizeTemp;
    if(totalTemp%pageSizeTemp >0)
      {
        totalPage +=1;
      }
    return totalPage<1?1:totalPage;
  }
  int getTotalElement(){
    int totalElement = (total??1);
    return totalElement<1?1:totalElement;
  }
}