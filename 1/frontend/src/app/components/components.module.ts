import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

import { IconComponent } from './icon/icon.component';
import { ModalComponent } from './modal/modal.component';

@NgModule({
  declarations: [IconComponent, ModalComponent],
  imports: [
    CommonModule,
    FontAwesomeModule,
    FormsModule
  ],
  exports: [IconComponent, ModalComponent]
})
export class ComponentsModule { }
