import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppRoutingModule } from '@app/app-routing.module';

import { MomentModule } from 'ngx-moment';

import { PostComponent } from './post.component';

@NgModule({
  declarations: [PostComponent],
  imports: [
    CommonModule,
    AppRoutingModule,
    MomentModule
  ]
})
export class PostModule { }
