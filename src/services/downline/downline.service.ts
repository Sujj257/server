import { Injectable } from '@nestjs/common';
import { DownlineDto } from './dto/downline.dto';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';

@Injectable()
export class DownlineService {
  constructor(private readonly db: DatabaseService) {}

  async GetDownline(payload: DownlineDto, sessionpayload: SessionPayloadDto) {
    try {
      const queryResponse = await this.db.executeFunc(
        'select sd_getdownlist($1,$2)',
        'sd_getdownlist',
        [sessionpayload.account_id, payload.show_my_acc],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
