import { Injectable } from '@angular/core';
import { Observable, combineLatest } from 'rxjs';
import { mergeMap, map, tap } from 'rxjs/operators';

import { HashService } from '@services/auth/hash.service';
import { SaltService } from '@services/models/auth/salt.service';
import { NonceService } from '@services/models/auth/nonce.service';
import { SessionService } from '@services/models/auth/session.service';
import { ActivationService } from '@services/models/auth/activation.service';
import { StorageService } from '@services/utils/storage.service';

import { Salt } from '@models/auth/salt.model';
import { Nonce } from '@models/auth/nonce.model';
import { Session } from '@models/auth/session.model';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  constructor(
    private hasher: HashService,
    private nonceApi: NonceService,
    private saltApi: SaltService,
    private sessionApi: SessionService,
    private activationApi: ActivationService,
    private storager: StorageService
  ) { }

  login(creds: { userName: string; password: string }): Observable<Session> {
    const { userName, password } = creds;
    const saltObs = this.saltApi.read(userName);
    const nonceObs = this.nonceApi.create(userName);

    return combineLatest(saltObs, nonceObs).pipe(
      mergeMap(([salt, nonce]: [Salt, Nonce]): Observable<Session> => {
        const hashedPassword = this.hasher.hashSecret(password, salt.value);
        const cnonce = new Nonce({ value: this.hasher.randomHash() });
        return this.sessionApi.create({ nonce, hashedPassword, cnonce });
      }),
      tap(session => this.storager.session = session)
    );
  }

  logout(): void {
    this.storager.clearSession();
  }

  activate(creds: { userName: string; password: string, token: string }): Observable<Session> {
    const { userName, password, token } = creds;
    const saltObs = this.saltApi.read(userName);
    const nonceObs = this.nonceApi.create(userName);

    return combineLatest(saltObs, nonceObs).pipe(
      mergeMap(([salt, nonce]: [Salt, Nonce]): Observable<Session> => {
        const hashedPassword = this.hasher.hashSecret(password, salt.value);
        const cnonce = new Nonce({ value: this.hasher.randomHash() });
        return this.activationApi.update({ nonce, hashedPassword, token, cnonce });
      }),
      tap(session => this.storager.session = session)
    );
  }
}
