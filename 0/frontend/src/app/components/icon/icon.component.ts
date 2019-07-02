import { Component, OnInit, Input } from '@angular/core';

import * as BrandIcons from '@fortawesome/free-brands-svg-icons';
import * as SolidIcons from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-icon',
  templateUrl: './icon.component.html',
  styleUrls: ['./icon.component.scss']
})
export class IconComponent implements OnInit {
  icon: BrandIcons.IconDefinition | SolidIcons.IconDefinition;
  @Input() iconName: string;
  @Input() size: number;

  constructor() { }

  ngOnInit() {
    if (BrandIcons[this.iconName]) {
      this.icon = BrandIcons[this.iconName];
    } else if (SolidIcons[this.iconName]) {
      this.icon = SolidIcons[this.iconName];
    }
  }

  get sizeClass(): string {
    return this.size ? `fa-${this.size}x` : null;
  }
}
