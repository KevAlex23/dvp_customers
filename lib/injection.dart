import 'package:get/get.dart';

import 'data/datasource/customer_datasource.dart';
import 'data/repositoryImp/address_repository_imp.dart';
import 'data/repositoryImp/customer_repository_imp.dart';
import 'domain/usecases/address_usecase.dart';
import 'domain/usecases/customer_usecase.dart';
import 'presentation/screens/home_screen/controllers/customer_list_screen_controller.dart';

Future<void> initializeDependencies() async {
  
  //Data sources
  Get.put(CustomerDataSourceImpl());
  
  //Repositories
  Get.put(CustomerRepositoryImp(customerDataSource: Get.find<CustomerDataSourceImpl>()));
  Get.put(AddressRepositoryImp(customerDataSource: Get.find<CustomerDataSourceImpl>()));

  //Use cases
  Get.put(CustomerUseCase(Get.find<CustomerRepositoryImp>()));
  Get.put(AddressUseCase(Get.find<AddressRepositoryImp>()));

  //View controllers
  Get.put(CustomerHomeScreenController());
  
}