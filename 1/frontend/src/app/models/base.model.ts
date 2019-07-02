import * as _ from 'lodash';

export abstract class Base {
  readonly params: any;
  readonly id: number;
  readonly type: string;
  readonly createdAt: string;
  readonly updatedAt: string;

  constructor(params: any = {}) {
    this.params = params;
    const { id, type, createdAt, updatedAt } = this.params;
    Object.assign(this, { id, type, createdAt, updatedAt });
    this.afterConstruction();
  }

  protected afterConstruction(): void { }

  serialize(): any {
    const { id, type, createdAt, updatedAt } = this;
    return Object.assign({ id, type, createdAt, updatedAt }, this.localSerialize());
  }

  protected localSerialize(): any {
    return {};
  }
}
