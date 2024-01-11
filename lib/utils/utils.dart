class Utils {
  double convertToDouble(String valor) {
    return double.parse(valor)!;
  }

  convertPagamento(String pagamento) {
    switch (pagamento) {
      case "Débito a vista":
        return "CartaoDebito";
      case "Crédito a vista":
        return "CartaoCredito";
      case "PIX":
        return "PagamentoInstantaneoPIX";
    }
  }
   String convertBandeiraToServer(String bandeira){
    switch(bandeira){
      case "VISA":
        return "Visa";
      case "MASTERCARD":
        return "Mastercard";
      case "AMERICANEXPRESS":
        return "AmericanExpress";
      case "SOROCRED":
        return "Sorocred";
      case "DINERSCLUB":
        return "DinersClub ";
      case "ELO":
        return "Elo";
      case "HIPERCARD":
        return "Hipercard";
      case "AURA":
        return "Aura";
      case "CABAL":
        return "Cabal";
      case "CABAL":
        return "Cabal";
      case "BANESCARD":
        return "BanesCard";
      case "CALCARD":
        return "CalCard";
      case "CREDZ":
        return "Credz";
      case "DISCOVER":
        return "Discover";
      case "GOODCARD":
        return "GoodCard";
      case "GREENCARD":
        return "GreenCard";
      case "HIPER":
        return "Hiper";
      case "JCB":
        return "JcB";
      case "MAIS":
        return "Mais";
      case "MAXVAN":
        return "MaxVan";
      case "POLICARD":
        return "Policard";
      case "REDECOMPRAS":
        return "RedeCompras";
      case "SODEXO":
        return "Sodexo";
      case "VALECARD":
        return "ValeCard";
      case "VEROCHEQUE":
        return "Verocheque";
      case "VR":
        return "VR";
      case "TICKET":
        return "Ticket";
      default:
        return "Outros";
    }


  }
}
