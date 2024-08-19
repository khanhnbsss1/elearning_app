import 'package:equatable/equatable.dart';

class SearchCommonRequest extends Equatable{
  int? page;
  int?totalPage;
  int? size;
  String? sort;
  int? id;
  int? userId;
  int? deviceId;
  String? name;
  String? deviceName;
  List<int>? status;
  String? timeFrom;
  String? timeTo;
  String? keyword;
  int? subAccount;
  List<int>?terminalIds;
  SearchCommonRequest({
    this.page,
    this.totalPage,
    this.size,
    this.sort,
    this.id,
    this.userId,
    this.deviceId,
    this.keyword,
    this.timeFrom,
    this.timeTo,
    this.name,
    this.status,
    this.subAccount,
    this.deviceName,
    this.terminalIds,
  });

  SearchCommonRequest copyWith(
      {
        int? page,
        int?totalPage,
        int? size,
        String? sort,
        int? id,
        int? userId,
        int? deviceId,
        String? name,
        List<int>? status,
        String? timeFrom,
        String? timeTo,
        String? keyword,
        int? subAccount,
        String? deviceName,
        List<int>?terminalIds,
      })
  {
    return SearchCommonRequest(
        page: page??this.page,
        totalPage: totalPage??this.totalPage,
        size: size??this.size,
        keyword: keyword??this.keyword,
      sort: sort??this.sort,
      id: id??this.id,
      userId: userId??this.userId,
      deviceId: deviceId??this.deviceId,
      name: name??this.name,
      status: status??this.status,
      timeFrom: timeFrom??this.timeFrom,
      timeTo: timeTo??this.timeTo,
      subAccount: subAccount??this.subAccount,
      deviceName: deviceName??this.deviceName,
      terminalIds: terminalIds??this.terminalIds,

    );
  }
  SearchCommonRequest.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPage = json['totalPage'];
    size = json['size'];
    sort = json['sort'];
    id = json['id'];
    userId = json['userId'];
    deviceId = json['deviceId'];
    keyword = json['keyword'];
    timeFrom = json['timeFrom'];
    timeTo = json['timeTo'];
    name = json['name'];
    status = json['status'];
    subAccount = json['subAccount'];
    deviceName = json['deviceName'];
    terminalIds = json['terminalIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(page!=null)
    {data['page'] = page;}
    if(size!=null)
    {data['size'] = size;}
    if(sort!=null)
    {data['sort'] = sort;}
    if(id!=null)
    {data['id'] = id;}
    if(userId!=null)
    {data['userId'] = userId;}
    if(deviceId!=null)
    {data['deviceId'] = deviceId;}

    if(keyword!=null)
    {
      data['keyword'] = keyword;
      data['searchText'] = keyword;
    }

    if(timeFrom!=null)
    {data['timeFrom'] = timeFrom;}

    if(timeTo!=null)
    {
      data['timeTo'] = timeTo;
    }
    
    if(name!=null)
    {
      data['name'] = name;
    }
    if(subAccount!=null)
    {
      data['subAccount'] = subAccount;
    }
    if(deviceName!=null)
    {
      data['deviceName'] = deviceName;
    }
    if(status!=null)
    {
      data['status'] = status;
    }
    if(terminalIds!=null)
    {
      data['terminalIds'] = terminalIds;
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [page, size, sort, id, userId, deviceId,
    keyword,timeFrom, timeTo, name, subAccount, deviceName];

}