import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

import { Session } from '@models/auth/session.model';

@Injectable({
  providedIn: 'root'
})
export class StorageService {
  private storageKey = 'redditSession';
  readonly session$: BehaviorSubject<Session> = new BehaviorSubject<Session>(new Session());

  constructor() {
    const session = JSON.parse(localStorage.getItem(this.storageKey));
    if (session) { this.session$.next(new Session(session)); }
  }

  set session(session: Session) {
    localStorage.setItem(this.storageKey, JSON.stringify(session));
    this.session$.next(session);
  }

  clearSession(): void {
    localStorage.removeItem(this.storageKey);
    this.session$.next(new Session());
  }
}
