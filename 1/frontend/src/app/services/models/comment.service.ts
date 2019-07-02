import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { ApiService } from '../utils/api.service';

import { CommentableHelper, Commentable } from '@models/helpers/commentable.helper';

import { Comment } from '@models/comment.model';
import { Post } from '@models/post.model';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  constructor(private api: ApiService) { }

  list(args: { postToken: string }): Observable<Comment[]> {
    const { postToken } = args;
    const route = `posts/${postToken}/comments`;
    return this.api.list({ route }).pipe(
      map(comments => comments.map(comment => new Comment(comment)))
    );
  }

  create(args: { commentable: Commentable, comment: Comment }): Observable<Comment> {
    const { commentable, comment } = args;
    const route = this.commentableCommentsRoute(commentable);

    return this.api.create({ route, body: comment }).pipe(
      map(comment => new Comment(comment))
    );
  }

  private commentableCommentsRoute(commentable: Commentable): string {
    if (CommentableHelper.isComment(commentable)) {
      return `comments/${commentable.token}/comments`;
    } else if (CommentableHelper.isPost(commentable)) {
      return `posts/${commentable.token}/comments`;
    }
  }
}
