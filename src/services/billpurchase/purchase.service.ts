import { Injectable } from '@nestjs/common';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';
import { DatabaseService } from '../database/database.service';
import { PurchaseDeleteDto } from './dto/deletebill.dto';
import { PurchaseBillDto, TicketsDto } from './dto/createbill.dto';
import { appConstants } from 'src/config/app.config';

@Injectable()
export class purchaseService {
  constructor(private readonly db: DatabaseService) { }

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

      if (appConstants.purchase_stop == true) {
        return { data: null, error: appConstants.purchase_error_msg };
      }

      if (payload.tickets.length <= 0) {
        return { data: null, error: 'No tickets found!' };
      }

      const errorlist: Array<any> = [];
      let billId: Array<object>;

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

        if (availablity.error == 'timeup') {
          return availablity;
        }


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
          billId = res.data.ticket_list;
          const valuesList = billId.map(obj => Object.values(obj)[0]);
          console.log(valuesList);

          for (var product of billId) {
            await this.db.RawQuery('UPDATE BOOKING_TICKETS SET TICKET_MAP_LIST = $1 ,C_NAME = $2  WHERE BOOKING_ID = $3', [valuesList, payload.customer_name, product[Object.keys(product)[0]]]);
          }
        }

        if (
          billId != undefined && billId.length > 0 &&
          parseInt(payload.tickets[index].count) != 0
        ) {
          console.log('UPDATED VALUE:');
          console.log(payload.tickets[index]);

          const count = parseInt(payload.tickets[index].count);
          let comission_camt: number =
            parseInt(payload.tickets[index].count) * appConstants.triple;

          if (['A', 'B', 'C'].includes(element.type)) {
            comission_camt = count * appConstants.single_double;
          }
          var ticketIds: number[] = [];

          for (var product of billId) {
            let accountidkey = Object.keys(product)[0];

            if (accountidkey == sessionpayload.account_id.toString() && sessionpayload.privilage_level == 2) {
              await this.db.RawQuery('UPDATE BOOKING_TICKETS SET SUB_PURCHASED = TRUE  WHERE BOOKING_ID = $1', [product[accountidkey]]);
            }
            var tic = await this.db.executeFunc(
              'select sd_create_ticket($1,$2,$3,$4,$5,$6,$7,$8,$9);',
              'sd_create_ticket',
              [
                accountidkey,
                product[accountidkey],
                element.type,
                element.number,
                count,
                parseInt(comission_camt.toFixed(2)),
                0.00,
                payload.draw_id,
                payload.p_date,
              ],
            );
            ticketIds.push(tic.data.ticket_id);
          }
          for (var product1 of ticketIds) {
            await this.db.RawQuery('UPDATE TICKET_TABLE SET TICKETID_MAP_LIST = $1  WHERE TICKET_ID = $2', [ticketIds, product1]);
          }
        }
      }
      if (billId === undefined) {
        return {
          data: {
            msg: 'today this number count is over!',
            notadded: errorlist,
          },
          error: null
        };
      } else {
        return {
          data: {
            // ticket_id: billId,
            msg: 'Bill Saved SuccessFully...',
            notadded: errorlist,
          },
          error: null
        };
      }
    } catch (error) {
      throw error;
    }
  }
}
