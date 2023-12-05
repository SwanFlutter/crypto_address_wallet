library crypto_address_wallet;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CryptoAddressWallet extends StatelessWidget {
  ///[hash] The cryptocurrency address hash to be displayed.
  final String hash;

  ///[style] The TextStyle to be applied to the address text.
  final TextStyle style;

  ///isShowCopyIcon A boolean flag indicating whether to display a copy icon next to the address.
  final bool isShowCopyIcon;

  ///[copyIcon] The IconData representing the copy icon.
  final IconData? copyIcon;

  ///[copyIconColor] The color of the copy icon.
  final Color copyIconColor;

  ///[copyIconSize] The size of the copy icon.
  final double copyIconSize;

  ///[addressFirstItemNumber] The number of characters to display from the beginning of the address hash.
  final int addressFirstItemNumber;

  ///[addressLastItemNumber] The number of characters to display from the end of the address hash.
  final int addressLastItemNumber;

  ///[textDirection] The text direction of the address text.
  final TextDirection? textDirection;

  ///[textAlign] The text alignment of the address text.
  final TextAlign? textAlign;

  ///[backgroundColorSnackbar] The background color of the snackbar that appears when the address is copied.
  final Color? backgroundColorSnackbar;

  const CryptoAddressWallet({
    Key? key,
    required this.hash,
    this.style = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.isShowCopyIcon = false,
    this.copyIcon = Icons.copy,
    this.copyIconColor = Colors.black,
    this.copyIconSize = 16,
    this.addressFirstItemNumber = 4,
    this.addressLastItemNumber = 4,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.center,
    this.backgroundColorSnackbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String address = formatAddress(hash);

    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hash));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard')),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            address,
            style: style,
            textAlign: textAlign,
            textDirection: textDirection,
          ),
          if (isShowCopyIcon)
            IconButton(
              icon: Icon(
                copyIcon,
                color: copyIconColor,
                size: copyIconSize,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hash));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: backgroundColorSnackbar ??
                        Theme.of(context).snackBarTheme.backgroundColor,
                    content: const Text('Copied to clipboard'),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String formatAddress(String address) {
    if (address.length <= 12) {
      return address;
    } else {
      String firstSix = address.substring(0, addressFirstItemNumber);
      String lastSix =
      address.substring(address.length - addressLastItemNumber);
      String hidden = "....";
      return "$firstSix$hidden$lastSix";
    }
  }
}
