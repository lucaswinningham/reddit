import { TestBed } from '@angular/core/testing';

import { SaltService } from './salt.service';

describe('SaltService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: SaltService = TestBed.get(SaltService);
    expect(service).toBeTruthy();
  });
});
