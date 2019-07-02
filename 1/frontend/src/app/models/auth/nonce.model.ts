import { Base } from '@models/base.model';

export class Nonce extends Base {
  readonly userName: string;
  readonly value: string;

  protected afterConstruction(): void {
    const { userName, value } = this.params;
    Object.assign(this, { userName, value });
  }
}
