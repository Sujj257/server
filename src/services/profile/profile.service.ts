import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { FetchProfileDto } from './dto/getprofile.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { UpdateProfileDto } from './dto/updateprofile.dto';
import { nulltransform } from 'src/utils/utils';

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
      const privilage_level = nulltransform(payload.privilage_level, true);
      const daily_limit = nulltransform(payload.daily_limit, true);
      const weekly_limit = nulltransform(payload.weekly_limit, true);

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
