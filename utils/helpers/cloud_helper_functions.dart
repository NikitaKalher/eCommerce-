import 'package:flutter/material.dart';

class TCloudHelperFunctions {
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return loader if provided, otherwise return CircularProgressIndicator
      return loader ?? const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      // Return nothingFound if provided, otherwise return a default 'No Data Found!' text
      return nothingFound ?? const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      // Return error widget if provided, otherwise return a default error message
      return error ?? const Center(child: Text('Something went wrong.'));
    }

    // Return null when the data is valid, indicating that the UI should proceed with rendering the data
    return null;
  }
}
