import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '@services/utils/api.service';

import { Nonce } from '@models/auth/nonce.model';

@Injectable({
  providedIn: 'root'
})
export class NonceService {

  constructor(private api: ApiService) { }

  create(userName: string): Observable<Nonce> {
    const route = `users/${userName}/nonce`;
    return this.api.create({ route }).pipe(
      map(nonce => new Nonce(nonce))
    );
  }
}
