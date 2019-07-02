import { Directive, ElementRef } from '@angular/core';

@Directive({
  selector: '[appHoverPointer]'
})
export class HoverPointerDirective {

  constructor(el: ElementRef) {
    el.nativeElement.style.cursor = 'pointer';
  }

}
