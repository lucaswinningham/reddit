import { Base } from '@models/base.model';

export class Sub extends Base {
  readonly name: string;

  protected afterConstruction(): void {
    const { name } = this.params;
    Object.assign(this, { name });
  }

  protected localSerialize(): any {
    const { name } = this;
    return { name };
  }
}
