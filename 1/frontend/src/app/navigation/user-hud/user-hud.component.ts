import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { StorageService } from '@services/utils/storage.service';
import { AuthService } from '@services/auth/auth.service';

import { Session } from '@models/auth/session.model';

@Component({
  selector: 'app-user-hud',
  templateUrl: './user-hud.component.html',
  styleUrls: ['./user-hud.component.scss']
})
export class UserHudComponent implements OnInit {
  session$: Observable<Session>;

  constructor(private storager: StorageService, public authService: AuthService) { }

  ngOnInit() {
    this.session$ = this.storager.session$;
  }

  logout(): void {
    this.authService.logout();
  }
}
