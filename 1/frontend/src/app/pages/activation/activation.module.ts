import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { ComponentsModule } from '@components/components.module';

import { ActivationComponent } from './activation.component';

@NgModule({
  declarations: [ActivationComponent],
  imports: [
    CommonModule,
    FormsModule,
    ComponentsModule
  ]
})
export class ActivationModule { }
