import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, ParamMap } from '@angular/router';
import { Subscription, combineLatest, of } from 'rxjs';
import { switchMap, finalize, catchError } from 'rxjs/operators';

import { AutoUnsubscribe } from '@decorators/auto-unsubscribe.decorator';

import { AuthService } from '@services/auth/auth.service';
import { LogService } from '@services/utils/log.service';

@Component({
  selector: 'app-activation',
  templateUrl: './activation.component.html',
  styleUrls: ['./activation.component.scss']
})
@AutoUnsubscribe()
export class ActivationComponent implements OnInit {
  userName: string;
  token: string;
  password: string;
  waiting = false;

  private subscription: Subscription = new Subscription();
  private paramSubscription: Subscription;

  constructor(
    private authService: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private logger: LogService
  ) { }

  ngOnInit() {
    this.paramSubscription = this.route.paramMap.pipe(
      switchMap((params: ParamMap) => {
        return of(['userName', 'token'].map(param => params.get(param)));
      })
    ).subscribe(([userName, token]: [string, string]) => {
      this.userName = userName;
      this.token = token;
    });
  }

  handleSubmit(): void {
    const { userName, token, password } = this;

    this.waiting = true;
    this.subscription = this.authService.activate({ userName, token, password }).pipe(
      finalize(() => this.waiting = false),
      catchError(this.logger.catchError())
    ).subscribe(() => {
      this.router.navigate(['/']);
    });
  }
}
