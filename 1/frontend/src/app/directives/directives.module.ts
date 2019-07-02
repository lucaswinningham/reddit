import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StopPropagationDirective } from './stop-propagation.directive';
import { HoverPointerDirective } from './hover-pointer.directive';

@NgModule({
  declarations: [StopPropagationDirective, HoverPointerDirective],
  imports: [
    CommonModule
  ],
  exports: [StopPropagationDirective, HoverPointerDirective]
})
export class DirectivesModule { }
