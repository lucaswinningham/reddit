import { Injectable } from '@angular/core';import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { User } from '@models/user.model';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private api: ApiService) { }

  read(name: string): Observable<User> {
    return this.api.read('users', name).pipe(
      map(user => new User(user))
    );
  }
}
