import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/functions/select_image.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/category_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/repository/product_repository.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_event.dart';
import 'package:oogie/screens/vendor_old/components/attribute.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  ProductRepository productRepository;
  String parentPage;
  String productId;
  ProductListByCreatorBloc productListByCreatorBloc;

  ProductModel productModel;
  AddProductBloc(
      {@required this.productRepository,
      this.parentPage,
        @required this.productListByCreatorBloc,
      @required this.productId})
      : super(AddProductState(
          isLoading: true,
          categories: [],
          brands: [],
          models: [],
          highlights: [],
          attributes: [],
          unitMeasures: [],
          specificationModels: [],
          images: [],
        )) {
    getBaseDate();
  }

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
    if (event is BaseDataUpdated) {
      yield state.copyWith(
          categories: event.categories,
          brands: event.brands,
          attributes: event.attributes,
          unitMeasures: event.unitMeasures,
          models: event.models,
          isLoading: false);
    } else if (event is SelectMedia) {
      // try {
      //   FilePickerResult result = await FilePicker.platform.pickFiles(
      //     type: FileType.any,
      //     allowCompression: true,
      //   );
      //   if (result != null) {
      //     PlatformFile platformFile = result.files.first;
      //     final File file = File(platformFile.path);
      //     state.images..add(file);
      //     yield state.copyWith();
      //   }
      // } catch (e) {
      //
      //  print(e);
      // }
      try {
        File temppfile;
        File file =
            await selectImage(imageFile: temppfile, context: event.context);

        state.images.add(file);
        yield state.copyWith();
      } catch (e) {
        print(e);
      }
    } else if (event is CategorySelected) {
      state.categories.every((element) => element.isSelected = false);
      state.categories[event.index].isSelected = true;
      yield state.copyWith();
    } else if (event is BrandSelected) {
      state.brands.every((element) => element.isSelected = false);
      state.brands[event.index].isSelected = true;
      yield state.copyWith(models: state.brands[event.index].subKeyValueModels);
    } else if (event is ModelSelected) {
      state.models.every((element) => element.isSelected = false);
      state.models[event.index].isSelected = true;
      yield state.copyWith();
    } else if (event is UnitOfMeasureSelected) {
      state.unitMeasures.every((element) => element.isSelected = false);
      state.unitMeasures[event.index].isSelected = true;
      yield state.copyWith();
    } else if (event is NameChanged) {
      yield state.copyWith(name: event.value);
    }  else if (event is PriceChanged) {
      yield state.copyWith(unitPrice: event.value);
    }  else if (event is DescriptionChanged) {
      yield state.copyWith(description: event.value);
    }  else if (event is QuantityAvailableChanged) {
      yield state.copyWith(qtyAvailable: event.value);
    } else if (event is AttributeSelected) {
      print('step 0');

      state.attributes[event.index].values.forEach((element) {
        element.isSelected = false;
        if (element.text == event.value) {
          element.isSelected = true;
        }
      });

      yield state.copyWith();
    } else if (event is AddNewSpecification) {
      print('step 0');
      if (event.index == null) {
        state.specificationModels.add(event.specificationModel);
      } else {
        state.specificationModels[event.index].values
            .add(event.subSpecificationModel);
      }

      yield state.copyWith();
    } else if (event is DeleteSpecification) {
      state.specificationModels.removeAt(event.index);

      yield state.copyWith();
    } else if (event is AddHighLight) {
      state.highlights.add('');

      yield state.copyWith();
    } else if (event is DeleteHighLight) {
      state.highlights.removeAt(event.index);

      yield state.copyWith();
    } else if (event is HighLightChanged) {
      state.highlights[event.index] = event.value;

      yield state.copyWith();
    } else if (event is AddProductSubmitted) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      try {

       String productId= await productRepository.addProduct(state:state, parentPage:'addProduct', isUsedProduct:'False');
       productListByCreatorBloc.add(NewProductAdded(productId: productId));

       yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
       yield state.copyWith(formSubmissionStatus: InitialFormStatus());
       //

      } catch (e) {
        yield state.copyWith(formSubmissionStatus: SubmissionFailed(e));
        yield state.copyWith(formSubmissionStatus: InitialFormStatus());
      }
    }
  }

  Future<void> getBaseDate() async {
    await productRepository.setCategories();
    List<CategoryModel> categories = await productRepository.getCategories();
    List<KeyValueRadioModel> brands = await productRepository.getProductBrand();
    List<AttributeModel> attributes = await productRepository.getAttributes();
    List<KeyValueRadioModel> unitOfMeasures =
        await productRepository.getUnitOfMeasures();
    List<KeyValueRadioModel> models= [];
    if(productId!=null) {
      productModel= await productRepository.getDetailsOfSelectedProduct(productId);
      
      categories.singleWhere((element) => element.id==productModel.categoryId).isSelected=true;
      brands.singleWhere((element) => element.value==productModel.brandId).isSelected=true;
      //
      models =brands.singleWhere((element) => element.value==productModel.brandId).subKeyValueModels;
      print(models.length);
      models.singleWhere((element) => element.value==productModel.modelId).isSelected=true;
      unitOfMeasures.singleWhere((element) => element.value==productModel.unitOfMeasureId).isSelected=true;
      attributes.forEach((element) {
        if(productModel.attributeLines.any((lineElement) => lineElement.value==element.id)){
          element.values.singleWhere((valueElement) => productModel.attributeLines.any((lineElement) => lineElement.key==valueElement.text)).isSelected=true;
        }
      });

      state.name=productModel.name;
      state.unitPrice=productModel.unitPrice;
      state.description=productModel.description;
      state.qtyAvailable=productModel.qtyAvailable.toString();
      state.specificationModels=productModel.specificationModels;
      state.highlights=productModel.highlights;
    //
    }
    add(BaseDataUpdated(
        unitMeasures: unitOfMeasures,
        attributes: attributes,
        brands: brands,
        models: models,
        categories: categories));
  }
}
