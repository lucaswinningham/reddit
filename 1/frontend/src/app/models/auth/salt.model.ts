import { Base } from '@models/base.model';

export class Salt extends Base {
  readonly value: string;

  protected afterConstruction(): void {
    const { value } = this.params;
    Object.assign(this, { value });
  }
}
