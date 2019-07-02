import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

import { SubService } from '@services/models/sub.service';

import { Sub } from '@models/sub.model';

@Component({
  selector: 'app-front',
  templateUrl: './front.component.html',
  styleUrls: ['./front.component.scss']
})
export class FrontComponent implements OnInit {
  sub: Sub;

  constructor(private subService: SubService, private route: ActivatedRoute) { }

  ngOnInit() {
    this.route.paramMap.pipe(
      switchMap((params: ParamMap) => this.subService.read(params.get('name')))
    ).subscribe(sub => this.sub = sub);
  }

}
