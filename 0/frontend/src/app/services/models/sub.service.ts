import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { Sub } from '@models/sub.model';

@Injectable({
  providedIn: 'root'
})
export class SubService {

  constructor(private api: ApiService) { }

  read(name: string): Observable<Sub> {
    return this.api.read('subs', name).pipe(
      map(sub => new Sub(sub))
    );
  }
}
