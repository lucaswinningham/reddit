import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { Post } from '@models/post.model';

@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private api: ApiService) { }

  list(args: { subName: string }): Observable<Post[]> {
    const { subName } = args;
    return this.api.list('posts', { subName }).pipe(
      map(posts => posts.map(post => new Post(post)))
    );
  }

  read(token: string): Observable<Post> {
    return this.api.read('posts', token).pipe(
      map(post => new Post(post))
    );
  }
}
