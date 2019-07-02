import { Component, OnInit, Input } from '@angular/core';
import { Observable } from 'rxjs';

import { PostService } from '@app/services/models/post.service';

import { Post } from '@models/post.model';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.scss']
})
export class PostListComponent implements OnInit {
  @Input() private subName: string;
  posts: Observable<Post[]>;

  constructor(private postService: PostService) { }

  ngOnInit() {
    const { subName } = this;
    this.posts = this.postService.list({ subName });
  }

}
