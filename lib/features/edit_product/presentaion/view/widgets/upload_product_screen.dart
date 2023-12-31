import 'package:ezy_buy_adminn/core/constant/constant.dart';
import 'package:ezy_buy_adminn/core/helper/functions.dart';
import 'package:ezy_buy_adminn/core/widgets/custom_app_bar.dart';
import 'package:ezy_buy_adminn/core/widgets/default_button.dart';
import 'package:ezy_buy_adminn/core/widgets/default_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;
  var validate = GlobalKey<FormState>();
  String? category;

  Future<void> _uploadProduct() async {
    validate.currentState!.validate();
    if (category == null) {
      AppFunction.showErrorORWarningDialog(
          context: context, subtitle: "Choose Category", fct: () {});
    }
  }

  Future<void> _clear() async {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    descriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: DefaultButton(
                  text: "Clear",
                  backGround: Colors.red,
                  press: () {
                    _clear();
                  },
                  icon: Icons.clear,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: DefaultButton(
                  text: "Upload Product",
                  backGround: Colors.blue,
                  press: () {
                    _uploadProduct();
                  },
                  icon: Icons.upload,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Upload A New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: validate,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              DropdownButton(
                  borderRadius: BorderRadius.circular(15.0),
                  hint: const Text("Select Category"),
                  items: AppConstants.categoryProducts,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  value: category,
                  onChanged: (String? value) {
                    setState(() {
                      category = value;
                    });
                  }),
              DefaultTextForm(
                type: TextInputType.multiline,
                textAction: TextInputAction.newline,
                hint: "Product Name",
                controller: titleController,
                maxLength: 80,
                maxLines: 1,
                minLines: 1,
                prefix: const Icon(
                  Icons.text_fields,
                ),
                submit: (calue) {},
                validate: (value) {
                  return AppFunction.validate(
                      value: value, returnText: "Please enter a product name");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: DefaultTextForm(
                      type: TextInputType.number,
                      hint: "Price",
                      controller: priceController,
                      maxLength: 80,
                      formatter: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                        ),
                      ],
                      maxLines: 1,
                      minLines: 1,
                      prefix: const Icon(
                        Icons.price_check_outlined,
                      ),
                      submit: (calue) {},
                      validate: (value) {
                        return AppFunction.validate(
                            value: value,
                            returnText: "Please enter a product price");
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: DefaultTextForm(
                      type: TextInputType.number,
                      hint: "quantity",
                      controller: quantityController,
                      maxLength: 80,
                      maxLines: 1,
                      formatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      minLines: 1,
                      prefix: const Icon(
                        Icons.numbers,
                      ),
                      submit: (calue) {},
                      validate: (value) {
                        return AppFunction.validate(
                            value: value,
                            returnText: "Please enter a product quantity");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: DefaultTextForm(
                  type: TextInputType.text,
                  hint: "Description",
                  controller: descriptionController,
                  maxLength: 1000,
                  maxLines: 8,
                  minLines: 5,
                  submit: (calue) {},
                  validate: (value) {
                    return AppFunction.validate(
                        value: value,
                        returnText: "Please enter a product Description");
                  },
                ),
              ),
              const SizedBox(
                height: kBottomNavigationBarHeight + 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
