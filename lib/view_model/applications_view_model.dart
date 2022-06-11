import 'package:loan_application_system/model/data.dart';
import 'package:loan_application_system/services/toast_message.dart';
import 'package:loan_application_system/utils/enums.dart';
import 'package:stacked/stacked.dart';

class ApplicationsViewModel extends BaseViewModel {

  List<CustomerApplications> customerApplications = Data.customerApplications;

  int pageNumber = 1;
  changePage(int value) async{
    pageNumber = value;
    await selectDataAccordingToPage();
    notifyListeners();
  }

  selectDataAccordingToPage() {
    if(pageNumber == 1) {
      customerApplications = Data.customerApplications;
    } else if(pageNumber == 2) {
      customerApplications = Data.customerApplicationsPage2;
    } else {
      customerApplications = Data.customerApplicationsPage3;
    }
  }

  List<Product> products = [
    Product.all,
    Product.creditCard,
    Product.autoFinance,
    Product.personalFinance,
  ];

  Product _productTypeSelected = Product.all;
  Product get productTypeSelected => _productTypeSelected;

  selectProductType(Product value) {
    _productTypeSelected = value;
    applyingFilter();
  }

  List<CustomerApplicationStatus> applicationStatusList = [
    CustomerApplicationStatus.all,
    CustomerApplicationStatus.complete,
    CustomerApplicationStatus.processing,
    CustomerApplicationStatus.delivery,
    CustomerApplicationStatus.declined,
    CustomerApplicationStatus.newA,
    CustomerApplicationStatus.accepted,
  ];

  CustomerApplicationStatus _applicationStatus = CustomerApplicationStatus.all;
  CustomerApplicationStatus get applicationStatus => _applicationStatus;

  selectApplicationStatus(CustomerApplicationStatus value) {
    _applicationStatus = value;
    applyingFilter();
  }

  applyingFilter() async{
    await selectDataAccordingToPage();

    List<CustomerApplications> filteredList = customerApplications
        .where((e) => ((_applicationStatus == CustomerApplicationStatus.all
            ? true
            : e.status == _applicationStatus)
        && (_productTypeSelected == Product.all
            ? true
            : e.product == _productTypeSelected)))
        .toList();

    if(filteredList.isEmpty) {
      toastMessage(message: "No result found");
    }
    customerApplications = filteredList;
    notifyListeners();
  }
}