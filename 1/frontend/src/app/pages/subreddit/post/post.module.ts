import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AppRoutingModule } from '@app/app-routing.module';
import { MomentModule } from 'ngx-moment';
import { FormsModule } from '@angular/forms';
// import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { DirectivesModule } from '@directives/directives.module';
import { ComponentsModule } from '@components/components.module';

import { PostComponent } from './post.component';
import { PostCommentComponent } from './post-comment/post-comment.component';

@NgModule({
  declarations: [PostComponent, PostCommentComponent],
  imports: [
    CommonModule,
    AppRoutingModule,
    MomentModule,
    DirectivesModule,
    ComponentsModule,
    FormsModule,
    // NgbModule
  ],
  exports: [PostComponent]
})
export class PostModule { }
