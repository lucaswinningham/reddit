import { Injectable } from '@angular/core';

import { environment } from '@env/environment';

import * as crypto from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class CipherService {
  encrypt(secret: string): string {
    return crypto.AES.encrypt(secret, this.cipherKey, { iv: this.cipherIv }).toString();
  }

  decrypt(secret: string): string {
    return crypto.AES.decrypt(secret, this.cipherKey, { iv: this.cipherIv }).toString(crypto.enc.Utf8);
  }

  private get cipherKey(): string {
    return crypto.enc.Base64.parse(environment.cipherKey);
  }

  private get cipherIv(): string {
    return crypto.enc.Base64.parse(environment.cipherIv);
  }
}
