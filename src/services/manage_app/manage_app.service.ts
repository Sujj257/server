import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { TimeDto } from './dto/get_time_dto';
import { ManageTicketDto } from './dto/ticket_manage_dto';
import { AppVersionDto } from './dto/appversions_dto';

@Injectable()
export class ManageAppService {
  constructor(private readonly db: DatabaseService) {}

  async timeManage(payload: TimeDto, sessionpayload: SessionPayloadDto) {
    try {
      var draw_id = parseInt(payload.draw_id);
      const queryResponse = await this.db.executeFunc(
        'select sd_time_manage($1,$2,$3,$4,$5)',
        'sd_time_manage',
        [
          draw_id,
          sessionpayload.account_id,
          payload.eventname,
          payload.eventtime,
          payload.isedit,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async ticketManage(
    payload: ManageTicketDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.draw_id == 'null' || payload.draw_id == '') {
        return { data: null, error: 'draw not found' };
      }
      var draw_id = parseInt(payload.draw_id);

      if (payload.isedit == false) {
        const queryResponse = await this.db.executeFunc(
          'select sd_ticket_manage($1,$2,$3,$4,$5)',
          'sd_ticket_manage',
          [draw_id, sessionpayload.account_id, '', 0, false],
        );
        return queryResponse;
      } else {
        console.log('inside');
        console.log(payload.value_lists);
        if (payload.value_lists.length <= 0) {
          return { data: null, error: 'no data to update' };
        } else {
          console.log('inside');
          for (let index = 0; index < payload.value_lists.length; index++) {
            const element = payload.value_lists[index];
            await this.db.executeFunc(
              'select sd_ticket_manage($1,$2,$3,$4,$5)',
              'sd_ticket_manage',
              [
                draw_id,
                sessionpayload.account_id,
                element.column_name,
                parseInt(element.column_value),
                payload.isedit,
              ],
            );
          }
        }
      }
      return { data: 'SUCCESS', error: null };
    } catch (error) {
      throw error;
    }
  }

  async appversions(payload: AppVersionDto, sessionpayload: SessionPayloadDto) {
    try {
      const queryResponse = await this.db.executeFunc(
        'select sd_appversions($1,$2,$3,$4,$5)',
        'sd_appversions',
        [
          payload.event_id,
          payload.keyname,
          payload.keyvalue,
          payload.isedit,
          sessionpayload.account_id,
        ],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }
}
