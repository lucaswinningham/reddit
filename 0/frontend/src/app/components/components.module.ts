import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

import { ModalComponent } from './modal/modal.component';
import { IconComponent } from './icon/icon.component';

@NgModule({
  declarations: [ModalComponent, IconComponent],
  exports: [ModalComponent, IconComponent],
  imports: [
    CommonModule,
    FontAwesomeModule
  ]
})
export class ComponentsModule { }
