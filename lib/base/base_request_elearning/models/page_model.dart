class PageModel{
  PageModel({this.total, this.pageSize, this.pageNumber});
  int? total;
  int? pageSize;
  int? pageNumber;
  int getCurrentPage(){
    int pageIndex = pageNumber??1;
/*    if(getTotalPage()<=pageIndex)
      {
        pageIndex = getTotalPage();
      }*/
    return pageIndex<1?1:pageIndex;
  }
  int getTotalPage(){
    int totalPage = ((total??1)~/ ((pageSize??0)>0?pageSize!:1));
    return totalPage<1?1:totalPage;
  }
  int getTotalElement(){
    int totalElement = (total??1);
    return totalElement<1?1:totalElement;
  }
}