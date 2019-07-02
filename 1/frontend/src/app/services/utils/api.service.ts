import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

import * as _ from 'lodash';

import { environment } from '@env/environment';
import { TransformService } from '@services/utils/transform.service';

const { apiUrl } = environment;

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  constructor(private http: HttpClient, private transformer: TransformService) { }

  list(args: { route: string, params?: any }): Observable<any> {
    const route = args.route;
    const params = args.params || {};
    const url = `${apiUrl}/${route}`;
    return this.process(this.http.get(url, { params }));
  }

  create(args: { route: string, body?: any }): Observable<any> {
    const route = args.route;
    const body = args.body ? this.snakeifyKeys(args.body) : {};
    const url = `${apiUrl}/${route}`;
    return this.process(this.http.post(url, body));
  }

  read(args: { route: string, param?: string | number, params?: any }): Observable<any> {
    const route = args.route;
    const param = args.param || '';
    const params = args.params || {};
    const url = `${apiUrl}/${route}/${param}`;
    return this.process(this.http.get(url, { params }));
  }

  update(args: { route: string, body?: any }): Observable<any> {
    const route = args.route;
    const body = args.body ? this.snakeifyKeys(args.body) : {};
    const url = `${apiUrl}/${route}`;
    return this.process(this.http.put(url, body));
  }

  private process(observable: Observable<any>): Observable<any> {
    return observable.pipe(
      catchError(this.catchError()),
      map(json => this.transformer.deserialize(json))
    );
  }

  private catchError(): (error: any) => Observable<any> {
    return (error: any): Observable<any> => {
      error.error = this.camelizeKeys(error.error);
      return throwError(error);
    };
  }

  private camelizeKeys(obj: any): any {
    return _.mapKeys(obj, (__: any, key: string) => _.camelCase(key));
  }

  private snakeifyKeys(obj: any): any {
    return _.mapKeys(obj, (__: any, key: string) => _.snakeCase(key));
  }
}
