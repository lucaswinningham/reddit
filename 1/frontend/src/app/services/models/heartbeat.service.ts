import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { ApiService } from '@services/utils/api.service';

@Injectable({
  providedIn: 'root'
})
export class HeartbeatService {

  constructor(private api: ApiService) { }

  read(): Observable<any> {
    const route = 'heartbeat';
    return this.api.read({ route });
  }
}
