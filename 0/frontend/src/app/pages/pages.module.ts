import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FrontModule } from './front/front.module';
import { SubModule } from './sub/sub.module';
import { PostModule } from './post/post.module';
import { UserModule } from './user/user.module';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    FrontModule,
    SubModule,
    PostModule,
    UserModule
  ]
})
export class PagesModule { }
