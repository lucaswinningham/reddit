import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FormsModule } from '@angular/forms';

import { ComponentsModule } from '@components/components.module';

import { CreatePostComponent } from './create-post.component';

@NgModule({
  declarations: [CreatePostComponent],
  imports: [
    CommonModule,
    FormsModule,
    ComponentsModule
  ]
})
export class CreatePostModule { }
