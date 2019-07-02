import { Component, OnInit, Input } from '@angular/core';
import { Subject, of, Subscription, Observable } from 'rxjs';
import { switchMap, tap, finalize } from 'rxjs/operators';

import { AutoUnsubscribe } from '@app/decorators/auto-unsubscribe.decorator';

import { CommentService } from '@services/models/comment.service';
import { StorageService } from '@app/services/utils/storage.service';
import { VoteService } from '@services/models/vote.service';

import { Post } from '@models/post.model';
import { Comment } from '@models/comment.model';
import { Session } from '@models/auth/session.model';
import { Vote } from '@models/vote.model';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.scss']
})
@AutoUnsubscribe()
export class PostComponent implements OnInit {
  @Input() post: Post;

  showComments = false;
  commentsWaiting = false;
  commentStream: Subject<void> = new Subject<void>();
  comments: Comment[];

  session$: Observable<Session>;

  reply: Comment;
  replyWaiting = false;

  voteStream: Subject<Vote> = new Subject<Vote>();
  upvoted = false;
  dnvoted = false;

  private commentCreateSubscription: Subscription = new Subscription();

  private commentStreamSubscription: Subscription;
  private voteStreamSubscription: Subscription;

  private vote: Vote = new Vote();

  constructor(
    private commentApi: CommentService,
    private storager: StorageService,
    private voteApi: VoteService
  ) { }

  ngOnInit() {
    this.session$ = this.storager.session$;

    this.commentStreamSubscription = this.listenToCommentStream();
    this.voteStreamSubscription = this.listenToVoteStream();
  }

  toggleComments(): void {
    this.commentStream.next();
  }

  newReply(): void {
    this.reply = new Comment();
  }

  clearReply(): void {
    this.reply = null;
  }

  handleReplySubmit(): void {
    const commentable = this.post;
    const comment = this.reply;

    this.replyWaiting = true;
    this.commentCreateSubscription = this.commentApi.create({ commentable, comment }).pipe(
      finalize(() => this.replyWaiting = false),
    ).subscribe(() => this.clearReply());
  }

  handleVote(newDirection: boolean): void {
    if (newDirection == this.vote.direction) {
      this.voteStream.next(new Vote({ direction: null }));
    } else {
      this.voteStream.next(new Vote({ direction: newDirection }));
    }
  }

  private listenToCommentStream(): Subscription {
    return this.commentStream.pipe(
      tap(() => this.commentsWaiting = true),
      switchMap(() => {
        if (!this.comments) {
          this.commentsWaiting = true;
          const postToken = this.post.token;
          return this.commentApi.list({ postToken }).pipe(
            tap(comments => this.comments = comments),
            finalize(() => this.commentsWaiting = false)
          );
        } else {
          return of(this.comments);
        }
      }),
      tap(() => this.commentsWaiting = false)
    ).subscribe(() => this.showComments = !this.showComments);
  }

  private listenToVoteStream(): Subscription {
    const token = this.post.token;
    return this.voteStream.pipe(
      switchMap((vote: Vote) => {
        return this.voteApi.createForPost({ token, vote }).pipe(
          tap((vote: Vote) => this.upvoted = vote.direction === true),
          tap((vote: Vote) => this.dnvoted = vote.direction === false),
          tap((vote: Vote) => this.vote = vote)
        )
      })
    ).subscribe();
  }
}
