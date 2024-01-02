import 'dart:io';

import 'package:ezy_buy_adminn/core/constant/constant.dart';
import 'package:ezy_buy_adminn/core/helper/functions.dart';
import 'package:ezy_buy_adminn/core/widgets/subtitle_text.dart';
import 'package:ezy_buy_adminn/core/widgets/title_text.dart';
import 'package:ezy_buy_adminn/features/edit_product/data/models/prodcut_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key, required this.productModel});
  final ProductModel? productModel;

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
  XFile? _pickedImage;
  bool isEditing = false;

  String? productNetworkImage;

//upload Image
  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await AppFunction.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  // remove Image
  void removePickedImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  //Upload Product
  Future<void> _uploadProduct() async {
    validate.currentState!.validate();
    if (category == null) {
      AppFunction.showErrorORWarningDialog(
          context: context, subtitle: "Choose Category", fct: () {});
    }
  }

  Future<void> _editProduct() async {
    final isValid = validate.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      AppFunction.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {}
  }

  Future<void> _clear() async {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      category = widget.productModel!.productCategory;
    }
    titleController =
        TextEditingController(text: widget.productModel?.productTitle);
    priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);

    super.initState();
  }

  @override
  void dispose() async {
    removePickedImage();
    titleController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomSheet: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.clear),
                  label: const Text(
                    "Clear",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    _clear();
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.upload),
                  label: Text(
                    isEditing ? "Edit Product" : "Upload Product",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    isEditing ? _editProduct() : _uploadProduct();
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: TitlesTextWidget(
            label: isEditing ? "Edit Product" : "Upload a new product",
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (isEditing && productNetworkImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      productNetworkImage!,
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ] else if (_pickedImage == null) ...[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1),
                    ),
                    width: size.width * 0.4 + 10,
                    height: size.width * 0.4,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.blue,
                          ),
                          TextButton(
                            onPressed: () {
                              localImagePicker();
                            },
                            child: const Text("Pick Product image"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(
                        _pickedImage!.path,
                      ),
                      // width: size.width * 0.7,
                      height: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
                if (_pickedImage != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          localImagePicker();
                        },
                        child: const Text("Pick another image"),
                      ),
                      TextButton(
                        onPressed: () {
                          removePickedImage();
                        },
                        child: const Text(
                          "Remove image",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
                const SizedBox(
                  height: 25,
                ),
                DropdownButton<String>(
                  hint: Text(category ?? "Select Category"),
                  value: category,
                  items: AppConstants.categoryProducts,
                  onChanged: (String? value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Form(
                    key: validate,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          key: const ValueKey('Title'),
                          maxLength: 80,
                          minLines: 1,
                          maxLines: 2,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                            hintText: 'Product Title',
                          ),
                          validator: (value) {
                            return AppFunction.validate(
                              value: value,
                              returnText: "Please enter a valid title",
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: priceController,
                                key: const ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'),
                                  ),
                                ],
                                decoration: const InputDecoration(
                                    hintText: 'Price',
                                    prefix: SubtitleTextWidget(label: '\$')),
                                validator: (value) {
                                  return AppFunction.validate(
                                    value: value,
                                    returnText: "Price is missing",
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                key: const ValueKey('Quantity'),
                                decoration: const InputDecoration(
                                  hintText: 'Qty',
                                ),
                                validator: (value) {
                                  return AppFunction.validate(
                                    value: value,
                                    returnText: "Quantity is missed",
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          key: const ValueKey('Description'),
                          controller: descriptionController,
                          minLines: 5,
                          maxLines: 8,
                          maxLength: 1000,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Product description',
                          ),
                          validator: (value) {
                            return AppFunction.validate(
                              value: value,
                              returnText: "Description is missed",
                            );
                          },
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
