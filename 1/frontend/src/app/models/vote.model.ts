import { Base } from '@models/base.model';

export class Vote extends Base {
  readonly direction: boolean;

  protected afterConstruction(): void {
    const { direction } = this.params;
    Object.assign(this, { direction });
  }

  protected localSerialize(): any {
    const { direction } = this;
    return { direction };
  }
}
