import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppRoutingModule } from '@app/app-routing.module';

import { MomentModule } from 'ngx-moment';
import { DirectivesModule } from '@directives/directives.module';

import { FrontComponent } from './front.component';
import { PostListComponent } from './post-list/post-list.component';
import { PostPreviewComponent } from './post-preview/post-preview.component';

@NgModule({
  declarations: [FrontComponent, PostListComponent, PostPreviewComponent],
  imports: [
    CommonModule,
    AppRoutingModule,
    MomentModule,
    DirectivesModule
  ]
})
export class FrontModule { }
