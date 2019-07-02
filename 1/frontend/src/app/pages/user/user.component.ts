import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { switchMap } from 'rxjs/operators';

import { UserService } from '@services/models/user.service';

import { User } from '@models/user.model';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit, OnDestroy {
  user: User;

  private paramSubscription: Subscription;

  constructor(private userApi: UserService, private route: ActivatedRoute) { }

  ngOnInit() {
    this.paramSubscription = this.route.paramMap.pipe(
      switchMap((params: ParamMap) => this.userApi.read(params.get('name')))
    ).subscribe(user => this.user = user);
  }

  ngOnDestroy() {
    this.paramSubscription.unsubscribe();
  }
}
