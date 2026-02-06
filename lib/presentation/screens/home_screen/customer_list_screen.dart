import 'package:dvp_customers/presentation/routes/app_routes.dart';
import 'package:dvp_customers/presentation/screens/home_screen/controllers/customer_list_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_list_tile.dart';
import '../../widgets/empty_list_view.dart';

class CustomerListScreen extends StatelessWidget {
  CustomerListScreen({super.key});
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String selectedOption = 'ASC';
    final List<String> options = ['ASC', 'DESC'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              'Customers',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: GetBuilder(
        id: "customers_list_view",
        init: Get.find<CustomerHomeScreenController>(),
        builder: (viewController) {
          viewController.context = context;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                viewController.customers.isEmpty
                    ? SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  viewController.getAllCustomers();
                                  return;
                                }
                                viewController.customers = viewController
                                    .customers
                                    .where(
                                      (customer) =>
                                          customer.name.toLowerCase().contains(
                                            value.toLowerCase(),
                                          ) ||
                                          customer.lastName
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          customer.email.toLowerCase().contains(
                                            value.toLowerCase(),
                                          ),
                                    )
                                    .toList();
                                viewController.update(["customers_list_view"]);
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          DropdownButton<String>(
                            value: selectedOption,
                            items: options.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedOption = newValue!;
                              selectedOption == 'ASC'
                                  ? viewController.customers.sort(
                                      (a, b) => a.name.compareTo(b.name),
                                    )
                                  : viewController.customers.sort(
                                      (a, b) => b.name.compareTo(a.name),
                                    );
                              viewController.update(["customers_list_view"]);
                            },
                          ),
                        ],
                      ),
                Expanded(
                  child: viewController.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : viewController.customers.isEmpty
                      ? EmptyListWidget()
                      : RefreshIndicator(
                          onRefresh: () => viewController.getAllCustomers(),
                          child: ListView.builder(
                            itemCount: viewController.customers.length,
                            itemBuilder: (context, index) {
                              final customer = viewController.customers[index];
                              return CustomListTile(
                                title: "${customer.name} ${customer.lastName}",
                                subtitle: customer.email,
                                trailingWidget: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  viewController.selectedCustomer = customer;
                                  Get.toNamed(
                                    RoutePages().customerInfoRoute,
                                  )?.whenComplete(() async {
                                    await Future.delayed(
                                      const Duration(milliseconds: 500),
                                    );
                                    await viewController.getAllCustomers();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutePages().customerAddRoute)?.whenComplete(() async {
            await Future.delayed(const Duration(milliseconds: 500));
            await Get.find<CustomerHomeScreenController>().getAllCustomers();
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.group_add_rounded,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
