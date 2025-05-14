import 'package:get/get.dart';
import 'package:kids_learning_app/features/cheat_sheet/models/cheat_sheet_model.dart';

class CheatSheetController extends GetxController {
  // Subject selection (French or Math)
  final Rx<String> selectedSubject = 'French'.obs;
  
  // Selected category filter
  final Rx<String?> selectedCategory = Rx<String?>(null);
  
  // Get current subject's categories
  List<CheatSheetCategory> get currentCategories => 
      selectedSubject.value == 'French' 
          ? CheatSheetData.frenchCategories 
          : CheatSheetData.mathCategories;
  
  // Get filtered cheat sheets based on selected subject and category
  List<CheatSheetCardModel> get filteredCheatSheets {
    final allSheets = selectedSubject.value == 'French'
        ? CheatSheetData.frenchCheatSheets
        : CheatSheetData.mathCheatSheets;
    
    if (selectedCategory.value == null) {
      return allSheets;
    }
    
    return allSheets.where((sheet) => 
        sheet.category == selectedCategory.value).toList();
  }
  
  // Switch subject
  void switchSubject(String subject) {
    selectedSubject.value = subject;
    selectedCategory.value = null; // Reset category filter when changing subject
  }
  
  // Set category filter
  void setCategory(String? category) {
    if (selectedCategory.value == category) {
      // Toggle off if same category selected twice
      selectedCategory.value = null;
    } else {
      selectedCategory.value = category;
    }
  }
}