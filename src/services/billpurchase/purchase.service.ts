import { Injectable } from '@nestjs/common';
import { PurchaseReportDto } from '../reports/dto/purchasereport.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { DatabaseService } from '../database/database.service';
import { PurchaseDeleteDto } from './dto/deletebill.dto';
import { PurchaseBillDto, TicketsDto } from './dto/createbill.dto';

@Injectable()
export class purchaseService {
  constructor(private readonly db: DatabaseService) {}

  async purchaseDelete(
    payload: PurchaseDeleteDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.ticket_id === 'null') {
        payload.ticket_id = null;
      } else {
        payload.ticket_id = parseInt(payload.ticket_id);
      }
      const queryResponse = await this.db.executeFunc(
        'select sd_deletebill($1,$2,$3)',
        'sd_deletebill',
        [sessionpayload.account_id, payload.bill_id, payload.ticket_id],
      );
      return queryResponse;
    } catch (error) {
      throw error;
    }
  }

  async CreatePurchase(
    payload: PurchaseBillDto,
    sessionpayload: SessionPayloadDto,
  ) {
    try {
      if (payload.tickets.length <= 0) {
        return { data: null, error: 'No tickets found!' };
      }

      let commission = await this.db.executeFunc(
        'select sd_getcommission($1)',
        'sd_getcommission',
        [sessionpayload.account_id],
      );

      const errorlist: Array<any> = [];
      let billId: number;

      for (const index in payload.tickets) {
        const element: TicketsDto = payload.tickets[index];
        const availablity = await this.db.executeFunc(
          'select sd_check_ticket_availability($1,$2,$3,$4,$5)',
          'sd_check_ticket_availability',
          [
            element.type,
            element.count,
            element.number,
            payload.draw_id,
            sessionpayload.account_id,
          ],
        );

        if (availablity.data != 'true') {
          const nonavailcount = availablity.data.count;
          const count = parseInt(payload.tickets[index].count);
          payload.tickets[index].count = (count - nonavailcount).toString();
          errorlist.push(availablity);
        }

        if (billId == null && parseInt(payload.tickets[index].count) != 0) {
          const res = await this.db.executeFunc(
            'select sd_booking_ticket($1,$2,$3,$4,$5,$6);',
            'sd_booking_ticket',
            [
              sessionpayload.account_id,
              payload.draw_id,
              0.0,
              0.0,
              0.0,
              payload.p_date,
            ],
          );
          billId = res.data;
        }

        if (
          billId != undefined &&
          parseInt(payload.tickets[index].count) != 0
        ) {
          const count = parseInt(payload.tickets[index].count);
          console.log(count);
          let comission_damt = 0;
          let comission_camt: number =
            parseInt(payload.tickets[index].count) * 10;
          commission = commission.data;

          if (element.type === 'DEAR') {
            comission_damt = count * commission.dc_dear;
          } else if (element.type === 'BOX') {
            comission_damt = count * commission.dc_box;
          } else if (['AB', 'BC', 'AC'].includes(element.type)) {
            comission_damt = count * commission.dc_double;
          } else {
            comission_damt = count * commission.dc_single;
            comission_camt = count * 12;
          }

          await this.db.executeFunc(
            'select sd_create_ticket($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);',
            'sd_create_ticket',
            [
              sessionpayload.account_id,
              billId,
              element.type,
              element.number,
              count,
              parseInt(comission_camt.toFixed(2)),
              parseInt(comission_damt.toFixed(2)),
              element.customer,
              payload.draw_id,
              payload.p_date,
            ],
          );
        }

        if (billId === undefined) {
          return {
            msg: 'today this number count is over!',
            notadded: errorlist,
          };
        } else {
          return {
            ticket_id: billId,
            msg: 'Bill Saved SuccessFully...',
            notadded: errorlist,
          };
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
