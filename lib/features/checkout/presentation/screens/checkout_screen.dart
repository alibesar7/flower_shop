import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          context.read<CheckoutCubit>()..doIntent(GetAddressIntent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1️⃣ Addresses
                  const Text(
                    'Select Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (state.addresses.isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state.addresses.isError)
                    Text(
                      state.addresses.error ?? 'Error loading addresses',
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (state.addresses.isSuccess)
                    ...state.addresses.data!.map(
                      (address) => AddressTile(
                        address: address,
                        isSelected: state.selectedAddress?.id == address.id,
                        onTap: () {
                          context.read<CheckoutCubit>().emit(
                            state.copyWith(selectedAddress: address),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 24),

                  // 2️⃣ Payment Method
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: PaymentMethod.values.map((method) {
                      return Expanded(
                        child: RadioListTile<PaymentMethod>(
                          value: method,
                          groupValue: state.paymentMethod,
                          title: Text(method.name.toUpperCase()),
                          onChanged: (val) {
                            context.read<CheckoutCubit>().emit(
                              state.copyWith(paymentMethod: val),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // 3️⃣ Gift Option
                  SwitchListTile(
                    title: const Text('Send as Gift?'),
                    value: state.isGift,
                    onChanged: (val) {
                      context.read<CheckoutCubit>().emit(
                        state.copyWith(isGift: val),
                      );
                    },
                  ),
                  if (state.isGift)
                    Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Recipient Name',
                          ),
                          onChanged: (val) => context
                              .read<CheckoutCubit>()
                              .emit(state.copyWith(giftName: val)),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Recipient Phone',
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => context
                              .read<CheckoutCubit>()
                              .emit(state.copyWith(giftPhone: val)),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  // 4️⃣ Order Summary
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SummaryRow(label: 'Subtotal', value: state.subTotal),
                  SummaryRow(label: 'Delivery Fee', value: state.deliveryFee),
                  const Divider(),
                  SummaryRow(label: 'Total', value: state.total),

                  const SizedBox(height: 24),

                  // 5️⃣ Place Order Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              context.read<CheckoutCubit>().doIntent(
                                CashOrderIntent(),
                              );
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Place Order'),
                    ),
                  ),

                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// -------------------- Widgets --------------------
class AddressTile extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressTile({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue.shade50 : null,
      child: ListTile(
        title: Text(address.city),
        subtitle: Text('${address.street}, ${address.city}'),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : null,
        onTap: onTap,
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double value;

  const SummaryRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text('\$${value.toStringAsFixed(2)}')],
      ),
    );
  }
}
