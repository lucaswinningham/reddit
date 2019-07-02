import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { StorageService } from '@services/utils/storage.service';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  constructor(private storager: StorageService) { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return this.storager.session$.pipe(
      mergeMap(session => {
        if (session.isValid) {
          request = request.clone({
            setHeaders: { Authorization: `Bearer ${session.token}` }
          });
        }

        return next.handle(request);
      })
    );
  }
}
