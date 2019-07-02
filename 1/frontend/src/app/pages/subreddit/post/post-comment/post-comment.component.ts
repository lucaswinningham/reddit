import { Component, OnInit, Input } from '@angular/core';
import { Observable, Subscription, Subject } from 'rxjs';
import { finalize, switchMap, tap } from 'rxjs/operators';

import { AutoUnsubscribe } from '@app/decorators/auto-unsubscribe.decorator';

import { StorageService } from '@services/utils/storage.service';
import { CommentService } from '@services/models/comment.service';
import { VoteService } from '@services/models/vote.service';

import { Comment } from '@models/comment.model';
import { Session } from '@models/auth/session.model';
import { Vote } from '@models/vote.model';

@Component({
  selector: 'app-post-comment',
  templateUrl: './post-comment.component.html',
  styleUrls: ['./post-comment.component.scss']
})
@AutoUnsubscribe()
export class PostCommentComponent implements OnInit {
  @Input() comment: Comment;

  session$: Observable<Session>;

  reply: Comment;
  replyWaiting = false;

  voteStream: Subject<Vote> = new Subject<Vote>();
  upvoted = false;
  dnvoted = false;

  private commentCreateSubscription: Subscription = new Subscription();

  private voteStreamSubscription: Subscription;

  private vote: Vote = new Vote();

  constructor(
    private storager: StorageService,
    private commentApi: CommentService,
    private voteApi: VoteService
  ) { }

  ngOnInit() {
    this.session$ = this.storager.session$;

    this.voteStreamSubscription = this.listenToVoteStream();
  }

  newReply(): void {
    this.reply = new Comment();
  }

  clearReply(): void {
    this.reply = null;
  }

  handleReplySubmit(): void {
    const commentable = this.comment;
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

  private listenToVoteStream(): Subscription {
    const token = this.comment.token;
    return this.voteStream.pipe(
      switchMap((vote: Vote) => {
        return this.voteApi.createForComment({ token, vote }).pipe(
          tap((vote: Vote) => this.upvoted = vote.direction === true),
          tap((vote: Vote) => this.dnvoted = vote.direction === false),
          tap((vote: Vote) => this.vote = vote)
        )
      })
    ).subscribe();
  }
}
