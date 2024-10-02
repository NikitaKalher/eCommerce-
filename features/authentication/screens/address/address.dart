import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/authentication/screens/address/widgets/single_address.dart';
import 'package:ecommerce/features/personalization/controller/address_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../address/models/address_model.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder<List<AddressModel>>(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {
              // Handle different states using helper function
              final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (response != null) return response;

              // Data is available
              final addresses = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (_, index) => TSingleAddress(
                  address: addresses[index],
                  onTap: () => controller.selectAddress(addresses[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
