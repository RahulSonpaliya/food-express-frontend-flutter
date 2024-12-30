import 'package:food_express_customer/data/remote/repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocatorCustomerApp() {
  locator.registerLazySingleton<Repository>(() => Network());
}
