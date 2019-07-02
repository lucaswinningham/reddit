import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '@services/utils/api.service';
import { CipherService } from '@services/auth/cipher.service';

import { Nonce } from '@models/auth/nonce.model';
import { Session } from '@models/auth/session.model';

@Injectable({
  providedIn: 'root'
})
export class ActivationService {
  constructor(private api: ApiService, private cipher: CipherService) { }

  update(
    args: { nonce: Nonce; hashedPassword: string, cnonce: Nonce, token: string }
  ): Observable<Session> {
    const { nonce, hashedPassword, cnonce, token } = args;

    const message = this.cipher.encrypt([nonce.value, hashedPassword, token, cnonce.value].join('||'));

    const route = `users/${nonce.userName}/activation`;
    const body = { message };

    return this.api.update({ route, body }).pipe(
      map(session => new Session(session))
    );
  }
}
