import * as crypto from 'crypto';

export class Cryptography {
  static encrypt(inputString: string): string {
    try {
      let k1: string, k2: string;
      let b1: string, b2: string;

      // Random key password
      const random = Math.floor(
        1000000000000000 + Math.random() * 9000000000000000,
      );
      const pwd = random.toString();

      // Find key
      k1 = pwd.substr(0, 8);
      k2 = pwd.substr(8, 8);

      // Find bit
      b1 = k1.length.toString();
      b2 = k2.length.toString();

      // Process
      const cipher = crypto.createCipheriv('aes-128-cbc', pwd, pwd);
      let encrypted = cipher.update(inputString, 'utf8', 'base64');
      encrypted += cipher.final('base64');

      // Set format
      encrypted = k2 + b1 + k1 + b2 + encrypted;
      const buffer = Buffer.from(encrypted, 'utf8');
      return buffer.toString('base64');
    } catch (error) {
      throw new Error('encryption_error');
    }
  }

  static decrypt(encodedString: string): string {
    try {
      const buffer = Buffer.from(encodedString, 'base64');
      encodedString = buffer.toString('utf8');
      let bit: number;
      let key: string, k1: string, k2: string;
      let b1: string, b2: string;
      let min: number, max: number;

      // Find bit
      b1 = encodedString.substr(8, 1);
      b2 = encodedString.substr(17, 1);

      // Find key
      k2 = encodedString.substr(0, 8);
      k1 = encodedString.substr(9, 8);
      key = k1 + k2;

      // Find cryptodata'
      bit = parseInt(b1) + parseInt(b2);
      min = bit + 2;
      max = encodedString.length - min;
      let cryptodata = encodedString.substr(min, max);

      // Process
      const decipher = crypto.createDecipheriv('aes-128-cbc', key, key);
      let decrypted = decipher.update(cryptodata, 'base64', 'utf8');
      decrypted += decipher.final('utf8');
      return decrypted;
    } catch (error) {
      throw new Error('encryption_error');
    }
  }
}
