import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { FetchCommissionDto } from './dto/fetchcommission.dto';
import { UpdateCommissionDto } from './dto/updatecommission.dto';

@Injectable()
export class CommissionService {
  constructor(private readonly db: DatabaseService) { }

  async FetchCommission(
    payload: FetchCommissionDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      const account_id =
        payload.account_id === 'null'
          ? sessionpayload.account_id
          : parseInt(payload.account_id);
      const queryResponse = await this.db.executeFunc(
        'select sd_getcommission($1)',
        'sd_getcommission',
        [account_id],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async UpdateCommmission(
    payload: UpdateCommissionDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      const account_id =
        parseInt(payload.account_id);
      const queryResponse = await this.db.executeFunc(
        'select sd_addcommission($1,$2,$3,$4,$5,$6)',
        'sd_addcommission',
        [
          account_id,
          payload.abc,
          payload.abbcac,
          payload.s_dear,
          payload.s_box,
          sessionpayload.account_id,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
