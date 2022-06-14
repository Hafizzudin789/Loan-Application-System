enum LayoutViewIndex {
  dashboardView,
  applicationsView,
  third,
  fourth;
  // profileView;
}

enum ProfileViewState{
  profile,
  security;
}

enum PopupMenuState {
  account,
  logout,
}


enum CustomerType {
  existing,
  newCustomer,
}

enum ApplicationFormState{
  cardPage,
  customerId,
  customerDetails,
  cardSelection,
  documents;
}

enum CustomerApplicationStatus {
  all("All Status"),
  newA("New"),
  processing("Processing"),
  complete("Complete"),
  accepted("Accepted"),
  delivery("Delivery"),
  declined("Declined");

  final String label;
  const CustomerApplicationStatus(this.label);
}

enum Product {
  all("All Product"),
  creditCard("Credit Card"),
  autoFinance("Auto Finance"),
  personalFinance("Personal Finance");

  final String value;
  const Product(this.value);
}

enum ResultLimit {
  ten(10),
  twenty(20),
  thirty(30),
  forty(40),
  fifty(50);

  final int value;
  const ResultLimit(this.value);
}