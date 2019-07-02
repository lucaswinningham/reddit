import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Observable } from 'rxjs';
import { switchMap } from 'rxjs/operators';

import { PostService } from '@services/models/post.service';

import { Post } from '@models/post.model';

@Component({
  selector: 'app-subreddit',
  templateUrl: './subreddit.component.html',
  styleUrls: ['./subreddit.component.scss']
})
export class SubredditComponent implements OnInit {
  posts: Observable<Post[]>;

  constructor(private postApi: PostService, private route: ActivatedRoute) { }

  ngOnInit() {
    this.posts = this.route.paramMap.pipe(
      switchMap((params: ParamMap) => {
        const subName = params.get('name');
        return this.postApi.list({ subName });
      })
    );
  }

}
