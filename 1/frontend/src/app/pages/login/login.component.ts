import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { finalize, catchError } from 'rxjs/operators';

import { AutoUnsubscribe } from '@decorators/auto-unsubscribe.decorator';

import { AuthService } from '@services/auth/auth.service';
import { LogService } from '@services/utils/log.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
@AutoUnsubscribe()
export class LoginComponent implements OnInit {
  userName: string;
  password: string;
  waiting = false;

  private returnUrl: string;
  private subscription: Subscription = new Subscription();

  constructor(
    private authService: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private logger: LogService
  ) { }

  ngOnInit() {
    this.authService.logout();
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
  }

  handleSubmit(): void {
    const { userName, password } = this;

    this.waiting = true;
    this.subscription = this.authService.login({ userName, password }).pipe(
      finalize(() => this.waiting = false),
      catchError(this.logger.catchError())
    ).subscribe(() => {
      this.router.navigate([this.returnUrl]);
    });
  }
}
