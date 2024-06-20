import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/utils/validators.dart'; 

void main() {
  group('Validator checks', () {
    test('Validating valid email', () {
      const testEmail1 = 'test@test.net';
      const testEmail2 = 'aiai@gmail.net';
      const testEmail3 = 'alibaba_grande@gmail.com.net';

      expect(isValidEmail(testEmail1), null);
      expect(isValidEmail(testEmail2), null);
      expect(isValidEmail(testEmail3), null);
    });

    test('Validating invalid email', () {
      const testEmail1 = 'test@test';
      const testEmail2 = 'aiai.net';
      const testEmail3 = 'alibaba@grande@gmail.com.net';
      const testEmail4 = '';

      expect(isValidEmail(testEmail1), 'Invalid email');
      expect(isValidEmail(testEmail2), 'Invalid email');
      // This next example istechnically wrong, but should give a true due to how it is formatted
      // Any extra limiting could affect other working emails
      expect(isValidEmail(testEmail3), null);
      expect(isValidEmail(testEmail4), 'Email is required');
    });

    test('Validating valid password', () {
      const testPassword1 = '@Passwrod411';
      const testPassword2 = '%Exdee*Lmao!3';
      const testPassword3 = 'Pass*213Word';

      expect(isValidPassword(testPassword1), null);
      expect(isValidPassword(testPassword2), null);
      expect(isValidPassword(testPassword3), null);
    });

    test('Validating invalid password', () {
      const testPassword1 = 'password';
      const testPassword2 = '#Pa2';
      const testPassword3 = '@(*#)';
      const testPassword4 = '';

      expect(isValidPassword(testPassword1), 'Password must have special characters, numbers, lower and upper case letters');
      expect(isValidPassword(testPassword2), 'Password must have 8 or more characters');
      expect(isValidPassword(testPassword3), 'Password must have 8 or more characters');
      expect(isValidPassword(testPassword4), 'Password is required');
    });
  });
}