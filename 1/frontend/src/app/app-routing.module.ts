import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { SubredditComponent } from '@pages/subreddit/subreddit.component';
import { UserComponent } from '@pages/user/user.component';
import { LoginComponent } from '@pages/login/login.component';
import { CreatePostComponent } from '@pages/create-post/create-post.component';
import { ActivationComponent } from '@pages/activation/activation.component';

import { LoginGuard } from '@guards/login.guard';

const routes: Routes = [
  { path: '', redirectTo: '/r/all', pathMatch: 'full' },
  { path: 'r/:name', component: SubredditComponent },
  { path: 'u/:name', component: UserComponent },
  { path: 'login', component: LoginComponent },
  { path: 'posts/create', component: CreatePostComponent, canActivate: [LoginGuard] },
  { path: 'u/:userName/activation/:token', component: ActivationComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
