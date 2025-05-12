import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';

/// Contrôleur global pour gérer l'état de la mascotte interactive
class MascotController extends GetxController {
  // Singleton pattern avec GetX
  static MascotController get to => Get.find<MascotController>();
  
  // État actuel observable
  Rx<MascotState> currentState = MascotState.idle.obs;
  Rx<MascotType> currentMascot = MascotType.elephant.obs;
  
  // Fonction pour changer l'état
  void changeState(MascotState newState) {
    currentState.value = newState;
  }
  
  // Fonction pour changer de mascotte
  void changeMascot(MascotType newMascot) {
    currentMascot.value = newMascot;
  }
  
  // Réagir à une réponse correcte
  void reactToCorrectAnswer() {
    currentState.value = MascotState.happy;
    
    // Revenir à l'état normal après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      currentState.value = MascotState.idle;
    });
  }
  
  // Réagir à une réponse incorrecte
  void reactToIncorrectAnswer() {
    currentState.value = MascotState.sad;
    
    // Revenir à l'état normal après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      currentState.value = MascotState.idle;
    });
  }
  
  // Montrer que la mascotte réfléchit
  void startThinking() {
    currentState.value = MascotState.thinking;
  }
  
  // Demander quelque chose
  void askQuestion() {
    currentState.value = MascotState.question;
  }
  
  // Célébrer un accomplissement
  void celebrate() {
    currentState.value = MascotState.celebrating;
    
    // Revenir à l'état normal après 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      currentState.value = MascotState.idle;
    });
  }
}