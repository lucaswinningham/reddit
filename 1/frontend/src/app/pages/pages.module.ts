import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SubredditModule } from './subreddit/subreddit.module';
import { UserModule } from './user/user.module';
import { CreatePostModule } from './create-post/create-post.module';
import { LoginModule } from './login/login.module';
import { ActivationModule } from './activation/activation.module';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    SubredditModule,
    UserModule,
    CreatePostModule,
    LoginModule,
    ActivationModule
  ]
})
export class PagesModule { }
