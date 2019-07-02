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

    const data = json['data'] || json;

    if (_.isArray(data)) {
      return data.map(resource => this.deserialize(resource));
    }

    const { id, type, attributes } = data;
    const relationships = _.mapValues(data.relationships, value => this.deserialize(value));

    return { id, type, ...attributes, ...relationships };
  }
}
