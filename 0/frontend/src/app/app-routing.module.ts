import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { FrontComponent } from '@pages/front/front.component';
import { PostComponent } from '@pages/post/post.component';
import { UserComponent } from '@pages/user/user.component';

const routes: Routes = [
  { path: '', redirectTo: '/r/all', pathMatch: 'full' },
  { path: 'r/:name', component: FrontComponent },
  { path: 'post/:token', component: PostComponent },
  { path: 'u/:name', component: UserComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
