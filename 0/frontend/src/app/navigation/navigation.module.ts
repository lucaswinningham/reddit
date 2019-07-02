import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppRoutingModule } from '@app/app-routing.module';

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { NavigationComponent } from './navigation.component';
import { HamburgerComponent } from './hamburger/hamburger.component';
import { LogoComponent } from './logo/logo.component';
import { SigninComponent } from './signin/signin.component';

import { ComponentsModule } from '@app/components/components.module';

@NgModule({
  declarations: [NavigationComponent, HamburgerComponent, LogoComponent, SigninComponent],
  imports: [
    CommonModule,
    AppRoutingModule,
    NgbModule,
    ComponentsModule
  ],
  exports: [NavigationComponent]
})
export class NavigationModule { }
