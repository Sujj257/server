import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { FetchProfileDto } from './dto/getprofile.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { UpdateProfileDto } from './dto/updateprofile.dto';

@Injectable()
export class ProfileService {
  constructor(private readonly db: DatabaseService) {}

  async FetchProfile(
    payload: FetchProfileDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      const queryResponse = await this.db.executeFunc(
        'select sd_profiledetails($1)',
        'sd_profiledetails',
        [payload.account_id],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async UpdateProfile(
    payload: UpdateProfileDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      const privilage_level =
        payload.privilage_level == 'null'
          ? null
          : parseInt(payload.privilage_level);
      const daily_limit =
        payload.daily_limit == 'null' ? null : parseInt(payload.daily_limit);
      const weekly_limit =
        payload.weekly_limit == 'null' ? null : parseInt(payload.weekly_limit);

      const queryResponse = await this.db.executeFunc(
        'select lg_updateaccount($1,$2,$3,$4,$5,$6,$7)',
        'lg_updateaccount',
        [
          parseInt(payload.account_id),
          payload.password,
          privilage_level,
          daily_limit,
          weekly_limit,
          sessionpayload.account_id,
          payload.block,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
