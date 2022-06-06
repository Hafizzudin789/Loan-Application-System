enum ProfileViewState{
  profile,
  security;
}

enum PopupMenuState {
  account,
  logout,
}

enum LayoutViewIndex {
  dashboardView,
  applicationsView,
  third,
  fourth;
  // profileView;
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
  newA("New"),
  processing("Processing"),
  complete("Complete"),
  accepted("Accepted"),
  delivery("Delivery"),
  declined("Declined");

  final String label;
  const CustomerApplicationStatus(this.label);
}