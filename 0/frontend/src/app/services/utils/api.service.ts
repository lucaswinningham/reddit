import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

import { environment } from '@env/environment';
import { LogService } from '@services/utils/log.service';
import { TransformService } from '@services/utils/transform.service';

import * as _ from 'lodash';

const { apiUrl } = environment;

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  constructor(private http: HttpClient, private logger: LogService, private transformer: TransformService) { }

  read(route: string, param: string | number = '', params: any = {}): Observable<any> {
    const endpoint = `${apiUrl}/${route}/${param}`;
    params = this.snakeifyKeys(params);
    const observable = this.http.get(endpoint, { params });
    return this.process(observable).pipe(
      catchError(this.catchError(`GET ${endpoint}`))
    );
  }

  list(route: string, params: any = {}): Observable<any> {
    const endpoint = `${apiUrl}/${route}`;
    params = this.snakeifyKeys(params);
    const observable = this.http.get(endpoint, { params });
    return this.process(observable).pipe(
      catchError(this.catchError(`GET ${endpoint}`))
    );
  }

  private snakeifyKeys(obj: any): any {
    return _.mapKeys(obj, (__: any, key: string) => _.snakeCase(key));
  }

  private process(observable: Observable<any>): Observable<any> {
    return observable.pipe(
      map(json => this.transformer.deserialize(json)),
    );
  }

  private catchError(message: string): (error: any) => Observable<any> {
    return (error: any): Observable<any> => {
      this.logger.error(`${message} error: ${error}`);
      return throwError(error);
    };
  }
}
