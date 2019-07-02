import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { Post } from '@models/post.model';

const rootSubNames = ['all'];

@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private api: ApiService) { }

  list(args: { subName: string }): Observable<Post[]> {
    const { subName } = args;
    const route = rootSubNames.includes(subName) ? 'posts' : `subs/${subName}/posts`;
    return this.api.list({ route }).pipe(
      map(posts => posts.map(post => new Post(post)))
    );
  }

  create(args: { post: Post }): Observable<Post> {
    const { post } = args;
    const route = `subs/${post.subName}/posts`;
    return this.api.create({ route, body: post }).pipe(
      map(post => new Post(post))
    );
  }
}
