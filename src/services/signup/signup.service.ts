import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SignupDto } from './dto/signup.dto';

@Injectable()
export class SignupService {
  constructor(private readonly db: DatabaseService) {}

  async createUser(payload: SignupDto) {
    try {
      var queryResponse = await this.db.executeFunc(
        'select lg_createaccount($1,$2,$3,$4,$5,$6)',
        'lg_createaccount',
        [
          payload.username,
          payload.password,
          parseInt(payload.privilage_level),
          parseInt(payload.daily_limit),
          parseInt(payload.weekly_limit),
          payload.account_id,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
