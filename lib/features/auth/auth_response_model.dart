enum ResponseStatus { success, failure }

class AuthModelResponse {
  String authToken;
  String? userId;
  List<FolderItem>? folderList;
  String? error;
  ResponseStatus status;

  AuthModelResponse(
    this.authToken,
    this.userId,
    this.folderList, {
    this.error,
    this.status = ResponseStatus.success,
  });

  // Getter methods
  String get accessToken => authToken;
  String get userIdGetter => userId ?? '';
  bool get isAuthenticated =>
      authToken.isNotEmpty && status == ResponseStatus.success;
  bool get hasError => error != null;
  bool get isSuccess => status == ResponseStatus.success;
  bool get isFailure => status == ResponseStatus.failure;

  factory AuthModelResponse.fromJson(Map<String, dynamic> json) {
    try {
      final token = json['token'] as String? ?? '';
      final userId = json['user_id'] as String?;

      List<FolderItem>? folderList;
      if (json['folderList'] != null) {
        try {
          folderList = (json['folderList'] as List)
              .map((i) => FolderItem.fromJson(i as Map<String, dynamic>))
              .toList();
        } catch (e) {
          print('Error parsing folderList: $e');
          folderList = [];
        }
      }

      return AuthModelResponse(token, userId, folderList,
          status: ResponseStatus.success);
    } catch (e) {
      print('Error parsing AuthModelResponse: $e');
      return AuthModelResponse('', null, null,
          error: 'Failed to parse response: $e',
          status: ResponseStatus.failure);
    }
  }
}

class FolderItem {
  String parentName;
  String parentId;
  List<ChildItem> children;
  String? error;

  FolderItem(this.parentName, this.parentId, this.children, {this.error});

  factory FolderItem.fromJson(Map<String, dynamic> json) {
    try {
      final parentName = json['parentName'] as String? ?? '';
      final parentId = json['parentId'] as String? ?? '';

      List<ChildItem> children = [];
      if (json['children'] != null) {
        try {
          children = (json['children'] as List)
              .map((i) => ChildItem.fromJson(i as Map<String, dynamic>))
              .toList();
        } catch (e) {
          children = [];
        }
      }

      return FolderItem(parentName, parentId, children);
    } catch (e) {
      // print('Error parsing FolderItem: $e');
      return FolderItem('', '', [], error: 'Failed to parse FolderItem: $e');
    }
  }
}

class ChildItem {
  String childName;
  int childId;
  String? error;

  ChildItem(this.childName, this.childId, {this.error});

  factory ChildItem.fromJson(Map<String, dynamic> json) {
    try {
      final childName = json['childName'] as String? ?? '';
      final childId = json['childId'] as int? ?? 0;

      return ChildItem(childName, childId);
    } catch (e) {
      print('Error parsing ChildItem: $e');
      return ChildItem('', 0, error: 'Failed to parse ChildItem: $e');
    }
  }
}
