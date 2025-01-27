import 'package:budget_buddy/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:uuid/uuid.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';
import 'package:get/get.dart';

Future getCategoryCreation(BuildContext context) {
  
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        String iconSelected = '';
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        final ValueNotifier<bool> isFormValid = ValueNotifier(false);
        void validateForm() {
          isFormValid.value = categoryNameController.text.isNotEmpty &&
              iconSelected.isNotEmpty &&
              categoryColor != Colors.white; // Ensure color is selected
        }

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                listener: (context, state) {
                  if (state is CreateCategorySuccess) {
                    Get.snackbar(
                      "Success",
                      "Created category!",
                      titleText: Text(
                        "Success",
                        style: TextStyle(
                          color:  Colors.green.shade900,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: Text(
                        "Created Category!",
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      colorText: Colors.green.shade900,
                      duration: const Duration(seconds: 10),
                      instantInit: true,
                      snackPosition: SnackPosition.TOP,
                      icon: Icon(SFSymbols.checkmark, color:  Colors.green.shade900, size: 35.0),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 8,
                      borderColor: Colors.green.shade600,
                      borderWidth: 0.9,
                      backgroundColor: Colors.green.shade50,
                      isDismissible: true,
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                      ),
                      snackStyle: SnackStyle.FLOATING,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      animationDuration: const Duration(milliseconds: 800),
                      maxWidth: 300.0,
                    );
                    
                    Navigator.pop(ctx, category);
                  } else if (state is CreateCategoryLoading) {
                    setState(() {
                      Get.snackbar(
                        "Loading",
                        "Please wait!",
                        titleText: Text(
                          "Loading",
                          style: TextStyle(
                            color:  Colors.blue.shade900,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        messageText: Text(
                          "Please wait!",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        colorText: Colors.blue.shade900,
                        duration: const Duration(seconds: 1),
                        instantInit: true,
                        snackPosition: SnackPosition.TOP,
                        icon: Icon(SFSymbols.hourglass, color:  Colors.blue.shade900, size: 35.0),
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        borderRadius: 8,
                        borderColor: Colors.blue.shade600,
                        borderWidth: 0.9,
                        backgroundColor: Colors.blue.shade50,
                        isDismissible: true,
                        mainButton: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                        ),
                        snackStyle: SnackStyle.FLOATING,
                        forwardAnimationCurve: Curves.easeOutBack,
                        reverseAnimationCurve: Curves.easeInBack,
                        animationDuration: const Duration(milliseconds: 800),
                        maxWidth: 300.0,
                      );

                      isLoading = true;
                    });
                  } else if(state is CreateCategoryFailure) {
                    Get.snackbar(
                      "Error",
                      "Could not create category!",
                      titleText: Text(
                        "Error",
                        style: TextStyle(
                          color:  Colors.red.shade900,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: Text(
                        "Could not create category!",
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      colorText: Colors.red.shade900,
                      duration: const Duration(seconds: 100),
                      instantInit: true,
                      snackPosition: SnackPosition.TOP,
                      icon: Icon(SFSymbols.xmark, color:  Colors.red.shade900, size: 35.0),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 8,
                      borderColor: Colors.red.shade600,
                      borderWidth: 0.9,
                      backgroundColor: Colors.red.shade50,
                      isDismissible: true,
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                      ),
                      snackStyle: SnackStyle.FLOATING,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      animationDuration: const Duration(milliseconds: 800),
                      maxWidth: 300.0,
                    );
                  }
                },
                child: AlertDialog(
                  title: const Text(
                    'Create New Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: categoryNameController,
                          onChanged: (_) => validateForm(),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              constraints: const BoxConstraints(
                                maxWidth: 360,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: categoryIconController,
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              constraints: const BoxConstraints(
                                maxWidth: 360,
                              ),
                              isDense: true,
                              filled: true,
                              suffixIcon: Icon(
                                isExpanded
                              ? SFSymbols.chevron_up
                              : SFSymbols.chevron_down,
                                  color: const Color.fromARGB(255, 156, 156, 156)),
                              fillColor: Colors.white,
                              hintText: 'Icon',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                              border: OutlineInputBorder(
                                  borderRadius: isExpanded
                                      ? const BorderRadius.vertical(
                                          top: Radius.circular(10))
                                      : BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        isExpanded
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5),
                                          itemCount: myCategoriesIcons.length,
                                          itemBuilder: (context, int i) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    iconSelected =
                                                        myCategoriesIcons[i];
                                                    validateForm();
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: iconSelected ==
                                                                myCategoriesIcons[
                                                                    i]
                                                            ? Colors.green
                                                            : Colors
                                                                .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  iconMap[myCategoriesIcons[i]] ?? SFSymbols.question,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: categoryColorController,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx2) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ColorPicker(
                                          pickerColor: Colors.white,
                                          onColorChanged: (value) {
                                            setState(
                                              () {
                                                categoryColor = value;
                                                validateForm();
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(ctx2);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Done',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              constraints: const BoxConstraints(
                                maxWidth: 360,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: categoryColor,
                              hintText: 'Colour',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.tertiary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ValueListenableBuilder<bool>(
                                  valueListenable: isFormValid,
                                  builder: (context, isFormValidValue, child) {
                                    return TextButton(
                                        onPressed: isFormValidValue
                                        ? () {
                                          setState(() {
                                            category.categoryId = const Uuid().v1();
                                            category.name =
                                                categoryNameController.text;
                                            category.icon = iconSelected;
                                            category.color = categoryColor.value;
                                          });
                                          context
                                              .read<CreateCategoryBloc>()
                                              .add(CreateCategory(category));
                                        }
                                        :null,
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'Create',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                  }
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
}
