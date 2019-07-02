import { Component } from '@angular/core';
import { Subscription } from 'rxjs';
import { finalize, catchError } from 'rxjs/operators';

import { AutoUnsubscribe } from '@decorators/auto-unsubscribe.decorator';

import { PostService } from '@services/models/post.service';

import { Post } from '@models/post.model';
import { Router } from '@angular/router';
import { LogService } from '@services/utils/log.service';

@Component({
  selector: 'app-create-post',
  templateUrl: './create-post.component.html',
  styleUrls: ['./create-post.component.scss']
})
@AutoUnsubscribe()
export class CreatePostComponent {
  post: Post = new Post();
  waiting = false;

  private subscription: Subscription = new Subscription();

  constructor(private postApi: PostService, private router: Router, private logger: LogService) { }

  handleSubmit(): void {
    const { post } = this;

    this.waiting = true;
    this.subscription = this.postApi.create({ post }).pipe(
      finalize(() => this.waiting = false),
      catchError(this.logger.catchError())
    ).subscribe(() => {
      this.router.navigate(['/']);
    });
  }
}
