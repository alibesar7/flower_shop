import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';

class CheckoutState {
  final bool isLoading;
  final Resource<List<AddressModel>> addresses; // <-- keep this
  final Resource<CashOrderModel> order;
  final AddressModel? selectedAddress;
  final PaymentMethod paymentMethod;
  final bool isGift;
  final String giftName;
  final String giftPhone;
  final double subTotal;
  final double deliveryFee;
  final String? error;

  CheckoutState({

    this.isLoading = false,
    Resource<List<AddressModel>>? addresses,
    Resource<CashOrderModel>? order,
    this.selectedAddress,
    this.paymentMethod = PaymentMethod.cash,
    this.isGift = false,
    this.giftName = '',
    this.giftPhone = '',
    this.subTotal = 0,
    this.deliveryFee = 0,
    this.error,
  })   : addresses = addresses ?? Resource.initial(),
        order = order ?? Resource.initial();
  factory CheckoutState.initial() => CheckoutState();

  double get total => subTotal + deliveryFee;

  CheckoutState copyWith({
    bool? isLoading,
        Resource<List<AddressModel>>? addresses,

    Resource<CashOrderModel>? order,
    AddressModel? selectedAddress,
    PaymentMethod? paymentMethod,
    bool? isGift,
    String? giftName,
    String? giftPhone,
    double? subTotal,
    double? deliveryFee,
    String? error,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
            addresses: addresses ?? this.addresses,

      order: order ?? this.order,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isGift: isGift ?? this.isGift,
      giftName: giftName ?? this.giftName,
      giftPhone: giftPhone ?? this.giftPhone,
      subTotal: subTotal ?? this.subTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      error: error ?? this.error,
    );
  }
}
