import 'package:d_reader_flutter/core/models/wallet.dart';
import 'package:d_reader_flutter/core/providers/global_provider.dart';
import 'package:d_reader_flutter/core/providers/wallet_provider.dart';
import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:d_reader_flutter/ui/widgets/common/buttons/rounded_button.dart';
import 'package:d_reader_flutter/ui/widgets/settings/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditWalletName extends StatelessWidget {
  final WalletModel wallet;
  const EditWalletName({
    super.key,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      body: WalletNameInputField(
        wallet: wallet,
      ),
      appBarTitle: 'Username',
    );
  }
}

class WalletNameInputField extends ConsumerStatefulWidget {
  final WalletModel wallet;
  const WalletNameInputField({
    super.key,
    required this.wallet,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WalletNameInputFieldState();
}

class _WalletNameInputFieldState extends ConsumerState<WalletNameInputField> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.wallet.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  saveWallet() async {
    final notifier = ref.read(globalStateProvider.notifier);
    notifier.update(
      (state) => state.copyWith(
        isLoading: true,
      ),
    );
    await ref.read(
      updateWalletProvider(
        UpdateWalletPayload(
          address: widget.wallet.address,
          name: _nameController.text,
        ),
      ).future,
    );
    notifier.update(
      (state) => state.copyWith(
        isLoading: false,
      ),
    );
    ref.invalidate(myWalletProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your wallet has been updated.'),
          duration: Duration(milliseconds: 500),
          backgroundColor: ColorPalette.dReaderGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: TextField(
            controller: _nameController,
            cursorColor: Colors.white,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.dReaderYellow100,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.dReaderYellow100,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.dReaderYellow100,
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              contentPadding: const EdgeInsets.all(8),
              labelText: 'Wallet Name',
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ValueListenableBuilder(
          valueListenable: _nameController,
          builder: (context, value, child) {
            return RoundedButton(
              text: 'Save',
              size: const Size(double.infinity, 48),
              isLoading: ref.watch(globalStateProvider).isLoading,
              onPressed: value.text.length > 2 ? saveWallet : null,
            );
          },
        ),
      ],
    );
  }
}
