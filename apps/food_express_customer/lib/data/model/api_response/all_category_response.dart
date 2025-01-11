import '../bean/category.dart';
import 'base_response.dart';

class AllCategoryResponse extends BaseResponse {
  List<Category> categoryList = List.empty(growable: true);

  AllCategoryResponse({required super.success, required super.message});

  factory AllCategoryResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    AllCategoryResponse allCategoryResponse =
        AllCategoryResponse(message: message, success: success);
    var catList = parsedJson["categoryList"] as List;
    allCategoryResponse.categoryList =
        catList.map((e) => Category.fromJson(e)).toList(growable: true);
    return allCategoryResponse;
  }
}
