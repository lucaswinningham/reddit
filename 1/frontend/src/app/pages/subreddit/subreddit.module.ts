import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SubredditComponent } from './subreddit.component';
import { PostModule } from './post/post.module';

@NgModule({
  declarations: [SubredditComponent],
  imports: [
    CommonModule,
    PostModule
  ]
})
export class SubredditModule { }
