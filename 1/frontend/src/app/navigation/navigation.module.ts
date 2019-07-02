import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppRoutingModule } from '@app/app-routing.module';

import { ComponentsModule } from '@components/components.module';

import { NavigationComponent } from './navigation.component';
import { UserHudComponent } from './user-hud/user-hud.component';

@NgModule({
  declarations: [NavigationComponent, UserHudComponent],
  imports: [
    CommonModule,
    AppRoutingModule,
    ComponentsModule
  ],
  exports: [NavigationComponent]
})
export class NavigationModule { }
