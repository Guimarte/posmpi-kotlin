class EndPoints {
  static String getToken() =>
      "https://idp.emissormpi.com.br/auth/realms/mpi/protocol/openid-connect/token";
  static String getCompanies() => "https://dev.mpi.app.br/api/user/companies";
  static String getPayments() => "https://dev.mpi.app.br/api/payment/getallopenpaymentsasync";
  static String putPayments() => "https://dev.mpi.app.br/api/payment/cardMachineResponseAsync";
}
