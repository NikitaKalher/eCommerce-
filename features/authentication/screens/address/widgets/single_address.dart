import 'package:ecommerce/features/address/models/address_model.dart';
import 'package:ecommerce/features/personalization/controller/address_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    final dark = THelperFunctions.isDarkMode(context);
    return Obx(() {

      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backGroundColor: selectedAddress
              ? TColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? TColors.darkGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spacesBtwItems),
          radius: 15,
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? TColors.light
                          : TColors.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(address.formattedPhoneNo,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
