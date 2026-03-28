import '../../domain/entity/address_model.dart';

class CheckoutState {
  final AddressModel? address;
  final String? paymentMethod;

  final bool isLoading;
  final String? errorMessage;
  final bool orderSuccess;

  CheckoutState({
    this.address,
    this.paymentMethod,
    this.isLoading = false,
    this.errorMessage,
    this.orderSuccess = false,
  });

  CheckoutState copyWith({
    AddressModel? address,
    String? paymentMethod,
    bool? isLoading,
    String? errorMessage,
    bool? orderSuccess,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      orderSuccess: orderSuccess ?? this.orderSuccess,
    );
  }
}