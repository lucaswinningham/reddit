import { Comment } from '@models/comment.model';
import { Post } from '@models/post.model';

export type Commentable = Comment | Post;

export class CommentableHelper {
  static isComment(commentable: Commentable): boolean {
    return commentable.type === 'comment';
  }

  static isPost(commentable: Commentable): boolean {
    return commentable.type === 'post';
  }
}
