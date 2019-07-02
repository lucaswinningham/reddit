import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '@services/utils/api.service';

import { Salt } from '@models/auth/salt.model';

@Injectable({
  providedIn: 'root'
})
export class SaltService {

  constructor(private api: ApiService) { }

  read(userName: string): Observable<Salt> {
    const route = `users/${userName}/salt`;
    return this.api.read({ route }).pipe(
      map(salt => new Salt(salt))
    );
  }
}
