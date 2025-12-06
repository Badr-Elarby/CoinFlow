import 'package:local_auth/local_auth.dart';

class FingerprintService {
  static LocalAuthentication localAuthentication = LocalAuthentication();

  static Future<bool> canCheckBiometrics() async {
    return await localAuthentication.canCheckBiometrics;
  }

  static Future<bool> authenticateBiometric() async {
    bool isBiometric = await localAuthentication.authenticate(
      localizedReason: "Please enter your fingerprint",
      biometricOnly: true,
      sensitiveTransaction: true,
    );
    return isBiometric;
  }

  static Future<bool> requestBiometric() async {
    await canCheckBiometrics();
    return authenticateBiometric();
  }
}
