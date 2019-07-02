import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-modal',
  templateUrl: './modal.component.html',
  styleUrls: ['./modal.component.scss']
})
export class ModalComponent {
  @Output() close: EventEmitter<any> = new EventEmitter<any>();

  dismiss(): void {
    this.close.emit();
  }
}
