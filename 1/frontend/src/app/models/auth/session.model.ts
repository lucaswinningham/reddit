import { Base } from '@models/base.model';
import { connectableObservableDescriptor } from 'rxjs/internal/observable/ConnectableObservable';

export class Session extends Base {
  readonly userName: string;
  readonly token: string;

  protected afterConstruction(): void {
    const { userName, token } = this.params;
    Object.assign(this, { userName, token });
  }

  get isValid(): boolean {
    return this.token && !this.tokenExpired;
  }

  private get tokenExpired(): boolean {
    const now = Math.floor(new Date().getTime() / 1000);
    return now > this.tokenPayload.exp;
  }

  private get tokenPayload(): { exp: number } {
    if (!this.token) { return { exp: Infinity }; }

    const payloadString = this.token.split('.')[1];
    return JSON.parse(atob(payloadString));
  }
}
