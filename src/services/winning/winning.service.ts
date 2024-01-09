import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { WinningDetailViewDto } from './dto/winninghistorydetail.dto';
import { nulltransform } from 'src/utils/utils';
import { WinningResultViewDto } from './dto/resultview.dto';
import { WinningPrizeUpdateDto } from './dto/winningprizeupdate.dto';
import { WinningCommissionDto } from './dto/winningcommission.dto';
import { WinningExecuteDto } from './dto/winningexecute.dto';

@Injectable()
export class WinningService {
  constructor(private readonly db: DatabaseService) { }

  async WinningExecute(
    payload: WinningExecuteDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {

      if (payload.sixth.length > 30) {
        return {
          data: null,
          error: 'unable to add more than 30 numbers on 6th prize',
        };
      }
      const sixth: string = '{' + payload.sixth.join(',') + '}';

      const queryResponse = await this.db.executeFunc(
        'select sd_executewinning($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)',
        'sd_executewinning',
        [
          payload.draw_id,
          payload.draw_date,
          payload.first,
          payload.second,
          payload.third,
          payload.forth,
          payload.fifth,
          sixth,
          1,
          payload.hidden_update,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async WinningDetailView(
    payload: WinningDetailViewDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.account_id === 'null') {
        payload.account_id = sessionpayload.account_id.toString();
      }
      const draw_id: number = nulltransform(payload.draw_id, true);

      const queryResponse = await this.db.executeFunc(
        'select sd_get_winningdetails($1,$2,$3,$4,$5)',
        'sd_get_winningdetails',
        [
          payload.account_id,
          payload.p_date,
          draw_id,
          payload.ticket_type,
          payload.number,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async ResultView(
    payload: WinningResultViewDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      const draw_id: number = nulltransform(payload.draw_id, true);
      const queryResponse = await this.db.executeFunc(
        'select sd_winningresult($1,$2,$3)',
        'sd_winningresult',
        [payload.from_date, payload.to_date, draw_id],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async WinningPrizeUpdate(
    payload: WinningPrizeUpdateDto,
    sessionpayload: SessionPayloadDto,
  ) {
    if (payload.account_id === 'null') {
      payload.account_id = sessionpayload.account_id.toString();
    }

    if (payload.updated_by === 'null') {
      payload.updated_by = sessionpayload.account_id.toString();
    }

    try {
      const queryResponse = await this.db.executeFunc(
        'select sd_update_winningprize($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)',
        'sd_update_winningprize',
        [
          payload.account_id,
          payload.updated_by,
          payload.dear_1st_prize,
          payload.dear_2st_prize,
          payload.dear_3st_prize,
          payload.dear_4st_prize,
          payload.dear_5st_prize,
          payload.dear_6st_prize,
          payload.abc_1st_prize,
          payload.abbcac_1st_prize,
          payload.box_same_1st_prize,
          payload.box_both_1st_prize,
          payload.box_both_2st_prize,
          payload.box_shuffle_1st_prize,
          payload.box_shuffle_2st_prize,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async WinningCommissionUpdate(
    payload: WinningCommissionDto,
    sessionpayload: SessionPayloadDto,
  ) {
    if (payload.account_id === 'null') {
      payload.account_id = sessionpayload.account_id.toString();
    }

    if (payload.updated_by === 'null') {
      payload.updated_by = sessionpayload.account_id.toString();
    }

    try {
      const queryResponse = await this.db.executeFunc(
        'select sd_update_winningcommission($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)',
        'sd_update_winningcommission',
        [
          payload.account_id,
          payload.updated_by,
          payload.dear_1st_prize_commission,
          payload.dear_2st_prize_commission,
          payload.dear_3st_prize_commission,
          payload.dear_4st_prize_commission,
          payload.dear_5st_prize_commission,
          payload.dear_6st_prize_commission,
          payload.abc_1st_prize_commission,
          payload.abbcac_1st_prize_commission,
          payload.box_same_1st_prize_commission,
          payload.box_both_1st_prize_commission,
          payload.box_both_2st_prize_commission,
          payload.box_shuffle_1st_prize_commission,
          payload.box_shuffle_2st_prize_commission,
          payload.block_from_draw,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
