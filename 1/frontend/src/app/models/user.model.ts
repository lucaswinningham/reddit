import { Base } from '@models/base.model';

export class User extends Base {
  readonly name: string;
  readonly email: string;

  protected afterConstruction(): void {
    const { name, email } = this.params;
    Object.assign(this, { name, email });
  }

  protected localSerialize(): any {
    const { name, email } = this;
    return { name, email };
  }
}
