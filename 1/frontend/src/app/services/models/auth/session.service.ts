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
export class SessionService {
  constructor(private api: ApiService, private cipher: CipherService) { }

  create(args: { nonce: Nonce; hashedPassword: string, cnonce: Nonce }): Observable<Session> {
    const { nonce, hashedPassword, cnonce } = args;

    const message = this.cipher.encrypt([nonce.value, hashedPassword, cnonce.value].join('||'));

    const route = `users/${nonce.userName}/session`;
    const body = { message };

    return this.api.create({ route, body }).pipe(
      map(session => new Session(session))
    );
  }
}
