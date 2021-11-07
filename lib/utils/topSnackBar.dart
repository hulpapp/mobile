import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';


showSnackBar(text, context,type) {
  if(type == 'success'){
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: text,
      ),
    );
  }else{
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }



}

