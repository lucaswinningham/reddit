import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { Heartbeat } from '@models/heartbeat.model';

@Injectable({
  providedIn: 'root'
})
export class HeartbeatService {

  constructor(private api: ApiService) { }

  read(): Observable<Heartbeat> {
    return this.api.read('heartbeat').pipe(
      map(heartbeat => new Heartbeat(heartbeat))
    );
  }
}
