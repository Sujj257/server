import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { PurchaseReportDto } from './dto/purchasereport.dto';
import { TopCountReportDto } from './dto/topcountreport.dto';
import { nulltransform } from 'src/utils/utils';
import { TotalCountReportDto } from './dto/totalcountreport.dto';
import { WinningReportDto } from './dto/winningreport.dto';
import { DailyReportDto } from './dto/dailyreport.dto';

@Injectable()
export class ReportsService {
  constructor(private readonly db: DatabaseService) {}

  async purchaseReport(
    payload: PurchaseReportDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }
      const queryResponse = await this.db.executeFunc(
        'select sd_purchasehistory($1,$2,$3,$4,$5,$6,$7,$8)',
        'sd_purchasehistory',
        [
          parseInt(payload.account_id),
          payload.from_date,
          payload.to_date,
          payload.draw_id,
          payload.getalldata,
          payload.filter,
          sessionpayload.account_id,
          payload.agent_rate,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async TopCountReport(
    payload: TopCountReportDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }
      const draw_id: number = nulltransform(payload.draw_id, true);

      const queryResponse = await this.db.executeFunc(
        'select sd_topcount($1,$2,$3,$4,$5,$6,$7)',
        'sd_topcount',
        [
          parseInt(payload.account_id),
          payload.from_date,
          payload.to_date,
          draw_id,
          payload.getalldata,
          payload.filter,
          sessionpayload.account_id,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async TotalCountReport(
    payload: TotalCountReportDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }
      const draw_id: number = nulltransform(payload.draw_id, true);

      const queryResponse = await this.db.executeFunc(
        'select sd_totalcount($1,$2,$3,$4,$5,$6)',
        'sd_totalcount',
        [
          parseInt(payload.account_id),
          payload.from_date,
          payload.to_date,
          draw_id,
          payload.getalldata,
          sessionpayload.account_id,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async WinningReport(
    payload: WinningReportDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }

      const draw_id: number = nulltransform(payload.draw_id, true);
      const filter = nulltransform(payload.filter, false);

      const queryResponse = await this.db.executeFunc(
        'select sd_winninghistory($1,$2,$3,$4,$5,$6,$7,$8)',
        'sd_winninghistory',
        [
          parseInt(payload.account_id),
          payload.from_date,
          payload.to_date,
          draw_id,
          payload.getalldata,
          filter,
          sessionpayload.account_id,
          payload.agent_rate,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async DailyReport(
    payload: DailyReportDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }

      const draw_id: number = nulltransform(payload.draw_id, true);
      const filter = nulltransform(payload.filter, false);

      const queryResponse = await this.db.executeFunc(
        'select sd_dailyreport($1,$2,$3,$4,$5,$6,$7,$8)',
        'sd_dailyreport',
        [
          parseInt(payload.account_id),
          payload.from_date,
          payload.to_date,
          draw_id,
          payload.getalldata,
          filter,
          sessionpayload.account_id,
          payload.agent_rate,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
