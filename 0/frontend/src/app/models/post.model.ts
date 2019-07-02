import { Base } from '@models/base.model';

export class Post extends Base {
  readonly userName: string;
  readonly subName: string;
  readonly title: string;
  readonly url: string;
  readonly body: string;
  readonly active: boolean;
  readonly token: string;
  readonly createdAt: string;

  protected afterConstruction(): void {
    const { userName, subName, title, url, body, active, token, createdAt } = this.params;
    Object.assign(this, { userName, subName, title, url, body, active, token, createdAt });
  }

  protected localSerialize(): any {
    const { userName, subName, title, url, body, active, token, createdAt } = this;
    return { userName, subName, title, url, body, active, token, createdAt };
  }
}
