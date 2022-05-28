import 'package:get_it/get_it.dart';
import 'package:loan_application_system/services/navigation_service.dart';

GetIt locator = GetIt.instance;

setUpServiceLocator() {
  locator.registerLazySingleton(() => NavigationService());
}