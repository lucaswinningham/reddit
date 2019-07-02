import { Injectable } from '@angular/core';

import randomString from 'random-string';
import * as bcryptjs from 'bcryptjs';

import { CipherService } from '@services/auth/cipher.service';

@Injectable({
  providedIn: 'root'
})
export class HashService {
  constructor(private cipher: CipherService) { }

  hashSecret(secret: string, salt: string): string {
    return bcryptjs.hashSync(secret, salt);
  }

  randomHash(): string {
    return this.cipher.encrypt(randomString({ length: 32 }));
  }
}
