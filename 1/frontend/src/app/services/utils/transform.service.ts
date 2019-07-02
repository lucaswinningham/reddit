import { Injectable } from '@angular/core';

import * as _ from 'lodash';

@Injectable({
  providedIn: 'root'
})
export class TransformService {
  deserialize(json: any): any {
    if (!json) {
      return;
    }

    const data = json.data || json;

    if (_.isArray(data)) {
      return data.map(resource => this.deserialize(resource));
    }

    const { id, type } = data;
    const attributes = this.deserializeAttributes(data.attributes);
    const relationships = this.deserializeRelationships(data.relationships);

    return { id, type, ...attributes, ...relationships };
  }

  private deserializeAttributes(attributes: any): any {
    const deserializedAttributes = _.mapValues(attributes, value => {
      if (value && _.isPlainObject(value)) {
        return this.deserialize(value);
      } else {
        return value;
      }
    });
    return this.camelCaseKeys(deserializedAttributes);
  }

  private deserializeRelationships(relationships: any): any {
    const deserializedRelationships = _.mapValues(relationships, value => this.deserialize(value));
    return this.camelCaseKeys(deserializedRelationships);
  }

  private camelCaseKeys(obj: any) {
    return _.mapKeys(obj, (__: any, key: string) => _.camelCase(key));
  }
}
