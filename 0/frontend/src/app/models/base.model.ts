import * as _ from 'lodash';

export abstract class Base {
  readonly params: any;
  readonly id: number;
  readonly type: string;

  constructor(params: any = {}) {
    this.params = this.camelCaseKeys(params);
    const { id, type } = this.params;
    Object.assign(this, { id, type });
    this.afterConstruction();
  }

  protected afterConstruction(): void { }

  serialize(): any {
    const { id, type } = this;
    return Object.assign({ id, type }, this.localSerialize());
  }

  protected localSerialize(): any {
    return {};
  }

  protected snakeifyKeys(obj: any): any {
    return _.mapKeys(obj, (__: any, key: string) => _.snakeCase(key));
  }

  private camelCaseKeys(obj: any) {
    return _.mapKeys(obj, (__: any, key: string) => _.camelCase(key));
  }
}
