import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { Vote } from '@models/vote.model';

@Injectable({
  providedIn: 'root'
})
export class VoteService {

  constructor(private api: ApiService) { }

  createForComment(args: { token: string, vote: Vote }): Observable<Vote> {
    const { token, vote } = args;
    const route = `comments/${token}/vote`;

    return this.api.create({ route, body: vote }).pipe(
      map(vote => new Vote(vote))
    );
  }

  createForPost(args: { token: string, vote: Vote }): Observable<Vote> {
    const { token, vote } = args;
    const route = `posts/${token}/vote`;

    return this.api.create({ route, body: vote }).pipe(
      map(vote => new Vote(vote))
    );
  }
}
