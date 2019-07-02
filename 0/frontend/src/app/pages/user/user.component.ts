import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

import { UserService } from '@services/models/user.service';

import { User } from '@models/user.model';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent implements OnInit {
  user: User;

  constructor(private userService: UserService, private route: ActivatedRoute) { }

  ngOnInit() {
    console.log('initing user component')
    this.route.paramMap.pipe(
      switchMap((params: ParamMap) => this.userService.read(params.get('name')))
    ).subscribe(user => this.user = user);
  }

}
