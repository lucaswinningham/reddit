import { Base } from '@models/base.model';

export class Comment extends Base {
  readonly userName: string;
  readonly content: string;
  readonly active: boolean;
  readonly token: string;
  readonly comments: Comment[];
  readonly votesCount: number;

  protected afterConstruction(): void {
    const { userName, content, active, token, votesCount } = this.params;
    const comments = (this.params.comments || []).map(comment => new Comment(comment));
    Object.assign(this, { userName, content, active, token, comments, votesCount });
  }

  get karma(): number {
    return this.votesCount;
  }

  protected localSerialize(): any {
    const { userName, content } = this;
    return { userName, content };
  }
}
